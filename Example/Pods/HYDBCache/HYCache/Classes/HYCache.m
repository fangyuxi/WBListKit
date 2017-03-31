//
//  HYCache.m
//  Pods
//
//  Created by fangyuxi on 16/4/15.
//
//

#import "HYCache.h"

@interface HYCache ()

@property (nonatomic, readwrite) HYMemoryCache *memCache;
@property (nonatomic, readwrite) HYDiskCache *diskCache;

@end

@implementation HYCache

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name directoryPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
}

- (instancetype __nullable)initWithName:(NSString *)name
                          directoryPath:(NSString *)directoryPath
{
    self = [super init];
    if (self)
    {
        _memCache = [[HYMemoryCache alloc] initWithName:name];
        _diskCache = [[HYDiskCache alloc] initWithName:name directoryPath:directoryPath];
        
        if (!_memCache ||!_diskCache) {
            _memCache = nil;
            _diskCache = nil;
            return nil;
        }
        return self;
    }
    return nil;
    
}

- (__nullable id)objectForKey:(NSString *)key
{
    if (!key) return nil;
    id object = [self.memCache objectForKey:key];
    if (!object)
    {
        object = [self.diskCache objectForKey:key];
        //回填到内存中
        [self.memCache setObject:object forKey:key];
    }
    return object;
}

- (void)objectForKey:(NSString *)key
           withBlock:(void (^)(NSString *key ,id __nullable object))block
{
    if (!block) return;
    id object = [self.memCache objectForKey:key];
    if (object)
    {
        block(key, object);
    }
    else
    {
        [self.diskCache objectForKey:key withBlock:^(HYDiskCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
            
            //回填到内存中
            [self.memCache setObject:object forKey:key];
            block(key, object);
        }];
    }
}

- (void)setObject:(id<NSCoding>)object
           forKey:(NSString *)key
                 inDisk:(BOOL)inDisk
{
    [self.memCache setObject:object forKey:key];
    if (inDisk) {
        [_diskCache setObject:object forKey:key];
    }
}

- (void)setObject:(id<NSCoding>)object
           forKey:(NSString *)key
           inDisk:(BOOL)inDisk
        withBlock:(void(^)())block
{
    if(!block) return;
    
    [self.memCache setObject:object forKey:key];
    
    if (inDisk) {
        [_diskCache setObject:object forKey:key withBlock:^(HYDiskCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
            block();
        }];
    }
}

- (void)removeAllObjects
{
    [self.memCache removeAllObject];
    [self.diskCache removeAllObject];
}

- (void)removeAllObjectsWithBlock:(void(^)())block
{
    [self.memCache removeAllObject];
    [self.diskCache removeAllObjectWithBlock:^(HYDiskCache * _Nonnull cache) {
       
        block();
    }];
}

- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(BOOL contained))block
{
//    BOOL contained = [_memCache containsObjectForKey:key];
//    if (contained){
//        
//        block(YES);
//    }
//    [_diskCache containsObjectForKey:key block:^(HYDiskCache * _Nonnull cache, NSString * _Nonnull key, id  _Nullable object) {
//       
//        if (object) {
//            block(YES);
//        }
//        else{
//            block(NO);
//        }
//    }];
}

@end




