//
//  HYDBRunnner.h
//  Pods
//
//  Created by fangyuxi on 2017/1/16.
//
//

#import <Foundation/Foundation.h>
#import "HYDiskCacheItem.h"

NS_ASSUME_NONNULL_BEGIN
/**
 同sqlite3进行交互 一个实例可以被多个线程共享 但是不可以多个线程同时操作
 
 使用我们自己编译的sqlite3库，要比苹果自带的快，同时也可进行源码级的优化
 
 sqlite优化点
 
 关闭内存申请统计
 sqlite3_config(SQLITE_CONFIG_MEMSTATUS, 0);
 尝试打开mmap
 sqlite3_config(SQLITE_CONFIG_MMAP_SIZE, (SInt64)kSQLiteMMapSize, (SInt64)-1);
 多个线程可以共享connection
 sqlite3_config(SQLITE_CONFIG_SINGLETHREAD);
 
 不支持后台操作，请在外部使用 'beginBackgroundTaskWithExpirationHandler:^{}'
 
 非线程安全，如果单独使用，请保证线程安全
 */

@interface HYDBStorage : NSObject

@property (nonatomic, assign) BOOL logsEnabled;

/**
 缓存SQL语句，如果为'YES'，会缓存SQL语句，降低CPU使用率，在合适的时候释放内存
 
            如果为'NO'， 不会缓存SQL，内存使用率低，CPU使用率高. 默认NO
 */
@property (nonatomic, assign) BOOL cachedSQL;

#pragma mark - Initializer

/**
 Designated initializer.
 
 Usually, you do not need to use this class out
 
 @param path 数据库地址的路径(不包含文件名)，会自动创建中间文件夹
 @return runner实例
 */
- (nullable instancetype)initWithDBPath:(NSString *)path NS_DESIGNATED_INITIALIZER;

// do not use
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
// do not use
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

#pragma mark save item

/**
 保存 item
 
 @param item One Item
 @return is succeed
 */
- (BOOL)saveItem:(HYDiskCacheItem *)item shouldStoreValueInDB:(BOOL)store;

/**
 save to db
 
 @param key 'key'
 @param value 'value is s NSDate instance'
 @param fileName 'fileName'
 @return is succeed
 */
- (BOOL)saveItemWithKey:(NSString *)key
              value:(NSData *)value
           fileName:(NSString *)fileName
             maxAge:(NSInteger)maxAge
shouldStoreValueInDB:(BOOL)store;

#pragma mark get item


/**
 获取 item

 @param key 'key'
 @return 'item'
 */
- (HYDiskCacheItem *)getItemForKey:(NSString *)key;

#pragma mark remove item

/**
 删除 item

 @param item 'item'
 @return is succeed
 */
- (BOOL)removeItem:(HYDiskCacheItem *)item;


/**
 remove  item with item's 'key'

 @param  key a item's 'key'
 @return is succeed
 */
- (BOOL)removeItemWithKey:(NSString *)key;


/**
 remove all

 @return is succeed
 */
- (BOOL)removeAllItems;


/**
 是否包含某个键值

 @param key 'key'
 @return is contained
 */
- (BOOL)containsItemForKey:(NSString *)key;


/**
 删除超过最大期限的item

 @return items.fileName
 */
- (NSArray *)removeOverdueByMaxAge;

#pragma mark get cache info


/**
 根据LRU算法，删除items

 @param count 'delete count'
 @return items.fileName
 */
- (NSArray *)removeItemsByLRUWithCount:(NSUInteger)count;

///**
// 返回指定key对应的条数，原则上只有一条或者没有
//
// @param key key
// @return count
// */
//- (NSInteger)getItemCountWithKey:(NSString *)key;

/**
 返回目前缓存的总大小

 @return size
 */
- (NSInteger)getTotalItemSize;

/**
 返回缓存数目

 @return count
 */
- (NSInteger)getTotalItemCount;


/**
 清空数据
 
 底层实现：删除数据库后重建数据库
 */
- (BOOL)reset;

@end

NS_ASSUME_NONNULL_END











