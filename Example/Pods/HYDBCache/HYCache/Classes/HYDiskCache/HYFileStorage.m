//
//  HYFileStorage.m
//  Pods
//
//  Created by fangyuxi on 2017/1/18.
//
//

#import "HYFileStorage.h"

@interface HYFileStorage ()
{
    NSString *_dataPath;
    NSString *_trashPath;
}

@end

@implementation HYFileStorage

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Do not use 'HYFileStorage's 'init method''" reason:@"Do not use 'HYFileStorage's 'init method''" userInfo:nil];
    
    return [self initWithPath:nil trashPath:nil];
}

- (instancetype)initWithPath:(NSString *)dataPath
                   trashPath:(NSString *)trashPath
{
    self = [super init];
    _dataPath = [dataPath copy];
    _trashPath = [trashPath copy];
    return self;
}

- (BOOL)writeData:(NSData *)data fileName:(NSString *)fileName
{
    NSString *path = [_dataPath stringByAppendingPathComponent:fileName];
    BOOL finish = [data writeToFile:path atomically:YES];
    return finish;
}

- (NSData *)fileReadWithName:(NSString *)fileName
{
    NSString *path = [_dataPath stringByAppendingPathComponent:fileName];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

- (BOOL)fileDeleteWithName:(NSString *)fileName
{
    NSString *path = [_dataPath stringByAppendingPathComponent:fileName];
    return [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

- (BOOL)fileDeleteWithNames:(NSArray *)fileNames
{
    BOOL result = true;
    for (NSString *name in fileNames) {
        result = [self fileDeleteWithName:name];
    }
    return result;
}

- (BOOL)fileMoveAllToTrash
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    
    NSString *tmpPath = [_trashPath stringByAppendingPathComponent:(__bridge NSString *)(uuid)];
    BOOL suc = [[NSFileManager defaultManager] moveItemAtPath:_dataPath toPath:tmpPath error:nil];
    CFRelease(uuid);
    return suc;
}

- (void)removeAllTrashFileInBackground
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *directoryContents = [manager contentsOfDirectoryAtPath:_trashPath error:NULL];
        for (NSString *path in directoryContents)
        {
            NSString *fullPath = [_trashPath stringByAppendingPathComponent:path];
            [manager removeItemAtPath:fullPath error:NULL];
        }
    });
}


@end
