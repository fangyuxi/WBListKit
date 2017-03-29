//
//  HYCache.h
//  <https://github.com/fangyuxi/HYCache>
//
//  Created by fangyuxi on 16/4/15.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "HYMemoryCache.h"
#import "HYDiskCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYCache : NSObject

/**
 *  内存缓存 可配置
 */
@property (nonatomic, readonly) HYMemoryCache *memCache;
/**
 *  闪存缓存 可配置
 */
@property (nonatomic, readonly) HYDiskCache *diskCache;

/**
 *  Do not use below init methods
 *
 *  @return nil
 */
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 *  init method
 *
 *  @param name name for debug call stack tree
 *
 *  @return cache
 */
- (instancetype __nullable)initWithName:(NSString *)name;

/**
 *  NS_DESIGNATED_INITIALIZER
 *
 *  @param name          name for debug call stack tree
 *  @param directoryPath path for diskCache defautl is library/cache/name
 *
 *  @return cache
 */
- (instancetype __nullable)initWithName:(NSString *)name
                       andDirectoryPath:(NSString *)directoryPath NS_DESIGNATED_INITIALIZER;

/**
 同步获取

 @param key `key`
 @return `object`
 */
- (__nullable id)objectForKey:(NSString *)key;

/**
 异步获取
 
 @param key `key`
 @param block 回调 非主线程
 @return `object`
 */
- (void)objectForKey:(NSString *)key
           withBlock:(void (^)(NSString *key ,id __nullable object))block;

/**
 *  存储Object 会阻塞线程
 *
 *  @param key    key
 *  @param inDisk 是否存储在disk中
 */
- (void)setObject:(id<NSCoding> __nullable)object
           forKey:(NSString *)key
           inDisk:(BOOL)inDisk;

/**
 *  存储Object 不阻塞线程，存储完毕回调block
 *
 *  @param key    key
 *  @param inDisk 是否存储在disk中
 *  @param block  block 回调 非主线程
 */
- (void)setObject:(id<NSCoding> __nullable)object
           forKey:(NSString *)key
           inDisk:(BOOL)inDisk
        withBlock:(void(^)())block;

/**
 *  移除对象 会阻塞线程
 */
- (void)removeAllObjects;

/**
 *  异步移除对象
 *
 *  @param block block
 */
- (void)removeAllObjectsWithBlock:(void(^)())block;

/**
 *  是否包含对象
 *
 *  @param key   key
 *  @param block block
 */
- (void)containsObjectForKey:(NSString *)key
                   withBlock:(void(^)(BOOL contained))block;
@end

NS_ASSUME_NONNULL_END
