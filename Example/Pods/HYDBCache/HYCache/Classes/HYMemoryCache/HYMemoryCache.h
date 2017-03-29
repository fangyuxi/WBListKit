//
//  HYMemoryCache.h
//  <https://github.com/fangyuxi/HYCache>
//
//  Created by fangyuxi on 16/4/5.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HYMemoryCache;

typedef void (^HYMemoryCacheBlock) (HYMemoryCache *cache);
typedef void (^HYMemoryCacheObjectBlock) (HYMemoryCache *cache, NSString *key, id __nullable object);


@interface HYMemoryCache : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 *  指定初始化函数
 *
 *  @param name 缓存的名字，会用于queue的名字，便于调试，
    如果有多个缓存对象，名字请唯一
 *
 *  @return cache object
 */
- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

/**
 *  name
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 *  当前的cost
 */
@property (nonatomic, assign, readonly) NSUInteger costNow;
/**
 *  设置最大cost
 */
@property (nonatomic, assign) NSUInteger costLimit;

/**
 *  移除时间间隔 cache会定期移除已经超过maxAge的对象
 */
@property (nonatomic, assign) NSTimeInterval trimToMaxAgeInterval;

/**
 *  默认 yes
 */
@property(nonatomic, assign) BOOL removeObjectWhenAppReceiveMemoryWarning;

/**
 *  默认 NO
 */
@property(nonatomic, assign) BOOL removeObjectWhenAppEnterBackground;

/**
 *  异步存储对象，该方法会立即返回，添加完毕之后block会在内部的concurrent queue中回调
    block
 *
 *  @param object 存储的对象，如果为空，则不会插入，block对象会回调
 *  @param key    存储对象的键，如果为空，则不会插入，block对象会回调
 *  @param block  存储结束的回调，在concurrent queue中执行
 */
- (void)setObject:(id __nullable)object
           forKey:(id)key
        withBlock:(HYMemoryCacheObjectBlock)block;

/**
 *  同步存储对象，该方法会阻塞调用的线程，直到存储完成
 *
 *  @param object 存储的对象，如果为空，则不会插入
 *  @param key    存储对象的键，如果为空，则不会插入
 */
- (void)setObject:(id __nullable)object
           forKey:(id)key;

/**
 *  异步存储对象，该方法会立即返回，添加完毕之后block会在内部的concurrent queue中回调
    block，cost为插入对象的大小，赋值有助于更准确的淘汰对象
 *
 *  @param object 存储的对象，如果为空，则不会插入，block对象会回调
 *  @param key    存储对象的键，如果为空，则不会插入，block对象会回调
 *  @param cost   cost为插入对象的大小，赋值有助于更准确的淘汰对象
 *  @param block  存储结束的回调，在concurrent queue中执行
 */
- (void)setObject:(id __nullable)object
           forKey:(id)key
         withCost:(NSUInteger)cost
        withBlock:(HYMemoryCacheObjectBlock)block;

- (void)setObject:(id __nullable)object
           forKey:(id)key
         withCost:(NSUInteger)cost
           maxAge:(NSTimeInterval)maxAge
        withBlock:(HYMemoryCacheObjectBlock)block;

/**
 *  同步存储对象，该方法会阻塞调用的线程，直到存储完成
    cost为插入对象的大小，赋值有助于更准确的淘汰对象
 *
 *  @param object 存储的对象，如果为空，则不会插入，block对象会回调
 *  @param key    存储对象的键，如果为空，则不会插入，block对象会回调
 *  @param cost   cost为插入对象的大小，赋值有助于更准确的淘汰对象
 */
- (void)setObject:(id __nullable)object
           forKey:(id)key
         withCost:(NSUInteger)cost;

- (void)setObject:(id __nullable)object
           forKey:(id)key
           maxAge:(NSTimeInterval)maxAge
         withCost:(NSUInteger)cost;
/**
 *  同步获取对象，该方法会阻塞调用的线程，直到获取完成
 *
 *  @param key 存储对象的键，不能为空
 *
 *  @return 如果没找到相应object则返回空
 */
- (id __nullable )objectForKey:(NSString *)key;

/**
 *  异步获取对象，该方法会立即返回，获取完毕之后block会在内部的concurrent queue中回调
 *
 *  @param key   存储对象的键，不能为空
 *  @param block 返回值 key object  cache object
 */
- (void)objectForKey:(id)key
           withBlock:(HYMemoryCacheObjectBlock)block;

/**
 *  异步移除对象，移除完毕之后block会在内部的concurrent queue中回调
 *
 *  @param key   存储对象的键，不能为空
 *  @param block 返回值 key object(已经被移除的对象) cache object
 */
- (void)removeObjectForKey:(id)key
                 withBlock:(HYMemoryCacheObjectBlock)block;

/**
 *  同步移除对象
 *
 *  @param key 存储对象的键，不能为空
 */
- (void)removeObjectForKey:(id)key;

/**
 *  异步移除所有对象，移除完毕之后block会在内部的concurrent queue中回调
 *
 *  @param block 返回值 cache object
 */
- (void)removeAllObjectWithBlock:(HYMemoryCacheBlock)block;

/**
 *  同步移除所有对象
 */
- (void)removeAllObject;

/**
 *  查询是否包含这个key value
 *
 *  @param key 存储对象的键，不能为空
 *
 *  @return BOOL
 */
- (BOOL)containsObjectForKey:(id)key;

/**
 *  移除对象，直到totalCostNow <= cost
 *
 *  @param cost  cost
 *  @param block 移除完毕之后block会在内部的concurrent queue中回调
 */
- (void)trimToCost:(NSUInteger)cost block:(HYMemoryCacheBlock)block;

/**
 *  移除对象，直到totalCostNow <= costLimit
 *
 *  @param block 移除完毕之后block会在内部的concurrent queue中回调
 */
- (void)trimToCostLimitWithBlock:(HYMemoryCacheBlock)block;

@end

NS_ASSUME_NONNULL_END
