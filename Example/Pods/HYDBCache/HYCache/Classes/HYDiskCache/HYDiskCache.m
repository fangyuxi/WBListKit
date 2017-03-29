//
//  HYDiskCache.m
//  Pods
//
//  Created by fangyuxi on 16/4/5.
//
//

#import "HYDiskCache.h"
#import <CommonCrypto/CommonCrypto.h>
#import "HYDBStorage.h"
#import "HYFileStorage.h"

NSString *const KHYDiskCacheFileSystemSpaceFullNotification = @"KHYDiskCacheFileSystemStorageSpaceFull";
NSString *const KHYDiskCacheErrorKeyFreeSpace = @"KHYDiskCacheErrorKeyFreeSpace";

NSInteger const KHYCacheItemMaxAge = -1;
NSInteger const KHYCacheDiskSpaceAlarmSize = 20 *  1024;

//当缓存文件大于16k的时候，将文件写入文件系统，不存入数据库，和NSURLCache一样
//sqlite3的数据写入要比写入文件快，但是读取的时候，大于16k的时候就开始慢于文件系统了
NSInteger const KHYCacheDBStorageThresholdSize  = 2014 * 16;

static NSString *const dataQueueNamePrefix = @"com.HYDiskCache.ConcurrentQueue.";

static NSString *const dataPath = @"data";
static NSString *const trushPath = @"trush";
static NSString *const metaPath = @"manifest";

#pragma mark lock

dispatch_semaphore_t semaphoreLock;

static inline void lock()
{
    dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
}

static inline void unLock()
{
    dispatch_semaphore_signal(semaphoreLock);
}

#pragma mark MD5

static NSString *HYMD5(NSString *string) {
    if (!string) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],  result[3],
            result[4],  result[5],  result[6],  result[7],
            result[8],  result[9],  result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark space free

static int64_t _HYDiskSpaceFree()
{
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error){
        return -1;
    }
    
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0){
        space = -1;
    }
    else if (space < KHYCacheDiskSpaceAlarmSize){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KHYDiskCacheFileSystemSpaceFullNotification object:@{KHYDiskCacheErrorKeyFreeSpace:@(space)}];
        });
    }
    
    return space;
}


#pragma mark HYCacheBackgourndTask

@interface _HYCacheBackgourndTask : NSObject

@property (nonatomic, assign) UIBackgroundTaskIdentifier taskId;

+ (instancetype)_startBackgroundTask;
- (void)_endTask;

@end

@implementation _HYCacheBackgourndTask

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.taskId = UIBackgroundTaskInvalid;
        self.taskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            
            UIBackgroundTaskIdentifier taskId = self.taskId;
            self.taskId = UIBackgroundTaskInvalid;
            
            [[UIApplication sharedApplication] endBackgroundTask:taskId];
        }];
        return self;
    }
    return nil;
}

+ (instancetype)_startBackgroundTask
{
    return [[self alloc] init];
}

- (void)_endTask
{
    UIBackgroundTaskIdentifier taskId = self.taskId;
    self.taskId = UIBackgroundTaskInvalid;
    
    [[UIApplication sharedApplication] endBackgroundTask:taskId];
}

@end


#pragma mark HYDiskCache

@interface HYDiskCache ()
{
    dispatch_queue_t _dataQueue; ///< concurrent queue
    HYDBStorage     *_db;        ///< db storage
    HYFileStorage   *_file;      ///< file storage
}

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *directoryPath;
@property (nonatomic, copy, readwrite) NSString *cachePath;
@property (nonatomic, copy, readwrite) NSString *cacheDataPath;
@property (nonatomic, copy, readwrite) NSString *cacheTrushPath;
@property (nonatomic, copy, readwrite) NSString *cacheManifestPath;

@end

@implementation HYDiskCache

@synthesize costLimit = _costLimit;
@synthesize totalCostNow = _totalCostNow;
@synthesize trimToMaxAgeInterval = _trimToMaxAgeInterval;
@synthesize customArchiveBlock = _customArchiveBlock;
@synthesize customUnarchiveBlock = _customUnarchiveBlock;

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"HYDiskCache Must Have A Name" reason:@"Call initWithName: instead." userInfo:nil];
    
    return [self initWithName:@"" andDirectoryPath:@""];
}

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name andDirectoryPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
}

- (instancetype)initWithName:(NSString *)name
            andDirectoryPath:(NSString *)directoryPath
{
    if (!name ||
        name.length == 0 ||
        !directoryPath ||
        directoryPath.length == 0 ||
        ![name isKindOfClass:[NSString class]] ||
        ![directoryPath isKindOfClass:[NSString class]])
    {
        @throw [NSException exceptionWithName:@"HYDiskCache Must Have A Name"
                                       reason:@"The Name and DirectoryPath Could Not Be NIL Or Empty"
                                     userInfo:nil];
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _name = [name copy];
        _directoryPath = [directoryPath copy];
        
        _costLimit = ULONG_MAX;
        _totalCostNow = 0;
        _trimToMaxAgeInterval = 40.0f;
        
        semaphoreLock = dispatch_semaphore_create(1);
        _dataQueue = dispatch_queue_create([dataQueueNamePrefix UTF8String], DISPATCH_QUEUE_CONCURRENT);
        
        _HYDiskSpaceFree();
        
        //创建路径
        if (![self p_createPath])
        {
            NSLog(@"HYDiskCache Create Path Failed");
            return nil;
        }
        
        _db = [[HYDBStorage alloc] initWithDBPath:_cacheManifestPath];
        _file = [[HYFileStorage alloc] initWithPath:_cacheDataPath trashPath:_cacheTrushPath];
        
        if (!_db || !_file) {
            _db = nil;
            _file = nil;
            return nil;
        }
        
        [self _trimToAgeLimitRecursively];
        
        return self;
    }
    return nil;
}

#pragma mark private method

- (BOOL)p_createPath
{
    _cachePath = [[_directoryPath stringByAppendingPathComponent:_name] copy];
    _cacheDataPath = [[_cachePath stringByAppendingPathComponent:dataPath] copy];
    _cacheTrushPath = [[_cachePath stringByAppendingPathComponent:trushPath] copy];
    _cacheManifestPath = [[_cachePath stringByAppendingPathComponent:metaPath] copy];
    
    if (![[NSFileManager defaultManager] createDirectoryAtPath:_cacheDataPath
                                   withIntermediateDirectories:YES
                                                    attributes:nil
                                                         error:nil] ||
        ![[NSFileManager defaultManager] createDirectoryAtPath:_cacheTrushPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil] ||
        ![[NSFileManager defaultManager] createDirectoryAtPath:_cacheManifestPath
                                   withIntermediateDirectories:YES
                                                    attributes:nil
                                                         error:nil])
    {
        return NO;
    }
    return YES;
}

#pragma mark store object

- (void)setObject:(id<NSCoding>)object
           forKey:(NSString *)key
        withBlock:(__nullable HYDiskCacheObjectBlock)block
{
    [self setObject:object forKey:key maxAge:KHYCacheItemMaxAge withBlock:block];
}

- (void)setObject:(id<NSCoding>)object
           forKey:(NSString *)key
           maxAge:(NSInteger)maxAge
        withBlock:(__nullable HYDiskCacheObjectBlock)block
{
    __weak HYDiskCache *weakSelf = self;
    dispatch_async(_dataQueue, ^{
        
        __strong HYDiskCache *stronglySelf = weakSelf;
        [stronglySelf setObject:object forKey:key maxAge:maxAge];
        
        if (block)
        {
            block(stronglySelf, key, object);
        }
    });
}

- (void)setObject:(id<NSCoding>)object
           forKey:(NSString *)key
{
    [self setObject:object forKey:key maxAge:KHYCacheItemMaxAge]; //never
}

- (void)setObject:(id<NSCoding>)object
           forKey:(NSString *)key
           maxAge:(NSInteger)maxAge
{
    if (!object || !key || ![key isKindOfClass:[NSString class]] || key.length == 0){
        return;
    }
    
    if (object == nil) {
        [self removeObjectForKey:key];
        return;
    }
    
    _HYCacheBackgourndTask *task = [_HYCacheBackgourndTask _startBackgroundTask];
    
    NSData *data;
    if (self.customArchiveBlock)
        data = self.customArchiveBlock(object);
    else
        data = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    //小于16k的数据只存数据库，大于16k的文件只存文件
    BOOL dbStorageOnly = data.length > KHYCacheDBStorageThresholdSize ? NO : YES;
    lock();
    NSString *fileName = HYMD5(key);
    BOOL finishDB = [_db saveItemWithKey:key
                   value:data
                fileName:fileName
                  maxAge:maxAge
    shouldStoreValueInDB:dbStorageOnly];
    unLock();
    
    if (!dbStorageOnly) {
        BOOL finishWrite = [_file writeData:data fileName:fileName];
        if (!finishWrite) {
            [_db removeItemWithKey:key];
        }
    }
    
    [task _endTask];
}

- (void)objectForKey:(id)key
           withBlock:(HYDiskCacheObjectBlock)block
{
    __weak HYDiskCache *weakSelf = self;
    dispatch_async(_dataQueue, ^{
        
        __strong HYDiskCache *stronglySelf = weakSelf;
        NSObject *object = [stronglySelf objectForKey:key];
        if (block)
        {
            block(stronglySelf, key, object);
        }
    });
}

- (id __nullable )objectForKey:(NSString *)key
{
    if (key.length == 0 || ![key isKindOfClass:[NSString class]]){
        return nil;
    }
        
    NSData *data;
    
    lock();
    HYDiskCacheItem *item = [_db getItemForKey:key];
    unLock();
    
    if (!item) {
        return nil;
    }
    if (item.maxAge != KHYCacheItemMaxAge && (NSInteger)time(NULL) - item.inTimeStamp > item.maxAge) {
        return nil;
    }
    
    item.value.length > 0 ? (data = item.value) : (data = [_file fileReadWithName:item.fileName]);
    
    id object;
    if (self.customUnarchiveBlock){
        object = self.customUnarchiveBlock(data);
    }
    else{
        @try {
            object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        @catch (NSException *exception) {
            [self removeObjectForKey:key];
            object = nil;
        }
    }
    return object;
}

- (void)removeObjectForKey:(NSString *)key
                 withBlock:(HYDiskCacheBlock)block
{
    __weak HYDiskCache *weakSelf = self;
    dispatch_async(_dataQueue, ^{
        
        __strong HYDiskCache *stronglySelf = weakSelf;
        [self removeObjectForKey:key];
        if (block)
        {
            block(stronglySelf);
        }
    });
}

- (void)removeObjectForKey:(NSString *)key
{
    if(![key isKindOfClass:[NSString class]] || key.length == 0) return;
    
    lock();
    HYDiskCacheItem *item = [_db getItemForKey:key];
    unLock();
    
    if (item) {
        NSString *fileName = item.fileName;
        if (fileName && fileName.length > 0) {
            [_file fileDeleteWithName:fileName];
        }
        lock();
        [_db removeItem:item];
        unLock();
    }
    
}

- (void)removeAllObjectWithBlock:(HYDiskCacheBlock)block
{
    __weak HYDiskCache *weakSelf = self;
    dispatch_async(_dataQueue, ^{
        
        __strong HYDiskCache *stronglySelf = weakSelf;
        [self removeAllObject];
        if (block)
        {
            block(stronglySelf);
        }
    });
}

- (void)removeAllObject
{
    lock();
    [_db removeAllItems];
    unLock();
    
    [_file fileMoveAllToTrash];
    [_file removeAllTrashFileInBackground];
}

- (BOOL)containsObjectForKey:(id)key
{
    if (!key) return NO;
    
    lock();
    BOOL contained = [_db containsItemForKey:key];
    unLock();
    
    return contained;
}

- (void)trimToCost:(NSUInteger)cost
             block:(HYDiskCacheBlock)block;
{
    if (cost == 0) {
        [self removeAllObjectWithBlock:block];
        return;
    }
    if (cost > self.totalCostNow) {
        return;
    }
    
    NSUInteger count = [_db getTotalItemCount];
    __weak HYDiskCache *weakSelf = self;
    dispatch_async(_dataQueue, ^{
        
        __strong HYDiskCache *stronglySelf = weakSelf;
        do{
            lock();
            NSArray *fileNames = [_db removeItemsByLRUWithCount:count / 10];
            unLock();
            
            [_file fileDeleteWithNames:fileNames];
            
        }
        while (self.totalCostNow >= cost);
        if (block){
            block(stronglySelf);
        }
    });
}

- (void)trimToCostLimitWithBlock:(HYDiskCacheBlock)block
{
    [self trimToCost:self.costLimit block:block];
}

- (void)_trimToAgeLimitRecursively
{
    lock();
    NSTimeInterval trimInterval = _trimToMaxAgeInterval;
    unLock();

    lock();
    NSArray *files = [_db removeOverdueByMaxAge];
    unLock();
    
    if (files.count) {
        [_file fileDeleteWithNames:files];
    }
    
    dispatch_time_t interval = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(trimInterval * NSEC_PER_SEC));
    
    __weak HYDiskCache *weakSelf = self;
    dispatch_after(interval, _dataQueue, ^{
        
        HYDiskCache *stronglySelf = weakSelf;
        [stronglySelf _trimToAgeLimitRecursively];
    });
}


#pragma mark getter setter for thread-safe

- (NSUInteger)totalCostNow
{
    lock();
    NSUInteger cost = [_db getTotalItemSize];
    unLock();
    return cost;
}

- (NSUInteger)costLimit
{
    
    lock();
    NSUInteger limit = _costLimit;
    unLock();
    
    return limit;
    
}

- (void)setCostLimit:(NSUInteger)byteCostLimit
{
    lock();
    _costLimit = byteCostLimit;
    unLock();
}

- (void)setTrimToMaxAgeInterval:(NSTimeInterval)trimToMaxAgeInterval
{
    lock();
    _trimToMaxAgeInterval = trimToMaxAgeInterval;
    unLock();
    
    [self _trimToAgeLimitRecursively];
}

- (NSTimeInterval)trimToMaxAgeInterval
{
    lock();
    NSTimeInterval age = _trimToMaxAgeInterval;
    unLock();
    
    return age;
}

- (void)setCustomArchiveBlock:(NSData * _Nonnull (^)(id _Nonnull))customArchiveBlock
{
    lock();
    _customArchiveBlock = [customArchiveBlock copy];
    unLock();
}

- (NSData * _Nonnull(^)(id _Nonnull))customArchiveBlock
{
    lock();
    NSData *(^block)(id)  = _customArchiveBlock;
    unLock();
    return block;
}

- (void)setCustomUnarchiveBlock:(id  _Nonnull (^)(NSData * _Nonnull))customUnarchiveBlock
{
    lock();
    _customUnarchiveBlock = [customUnarchiveBlock copy];
    unLock();
}

- (id (^)(NSData *))customUnarchiveBlock
{
    lock();
    id (^block)(NSData *) = _customUnarchiveBlock;
    unLock();
    return block;
}

@end









