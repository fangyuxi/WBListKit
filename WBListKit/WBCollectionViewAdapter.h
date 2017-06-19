//
//  WBCollectionViewAdapter.h
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import "WBCollectionSupplementaryItem.h"

NS_ASSUME_NONNULL_BEGIN
@class WBCollectionSection;
@class WBCollectionItem;

@protocol WBListActionToControllerProtocol;

@interface WBCollectionViewAdapter : NSObject

@property (nonatomic, weak, readonly) UICollectionView *collectionView;

#pragma mark Section Model

/**
 get section at index
 
 @param index 'index'
 */
- (WBCollectionSection *)sectionAtIndex:(NSUInteger)index;

/**
 get section with identifier
 
 @param key 'key'
 @return section
 */
- (WBCollectionSection *)sectionForKey:(NSString *)key;

/**
 get index of section
 
 @param section 'section'
 @return index
 */
- (NSUInteger)indexOfSection:(WBCollectionSection *)section;

/**
 append section
 
 @param block 'block'
 */
- (void)addSection:(void(^)(WBCollectionSection *newSection))block;

/**
 add section at index
 
 @param block 'block'
 @param index '指定位置'
 */
- (void)insertSection:(void(^)(WBCollectionSection *newSection))block
              atIndex:(NSUInteger)index;

/**
 更新指定位置的section
 
 @param index 'index'
 @param block 'block'
 */
- (void)updateSectionAtIndex:(NSUInteger)index
                    userBlock:(void(^)(WBCollectionSection *section))block;


/**
 更新指定的id的section
 
 @param key 'key'
 @param block 'block'
 */
- (void)updateSectionForIdentifier:(NSString *)key
                          userBlock:(void(^)(WBCollectionSection *section))block;

/**
 删除Section操作
 */
- (void)deleteSection:(WBCollectionSection *)section;
- (void)deleteSectionAtIndex:(NSUInteger)index;
- (void)deleteSectionForKey:(NSString *)key;
- (void)deleteAllSections;

#pragma mark Supplementary View Model

/**
 添加增补视图的Model, indexPath 必须要和layout对象中配置过的SupplementaryView相匹配

 @param item 'item'
 @param indexPath 'indexPath'
 */
- (void)addSupplementaryItem:(WBCollectionSupplementaryItem *)item
                   indexPath:(NSIndexPath *)indexPath;
/**
 删除增补视图

 @param indexPath 'indexPath'
 */
- (void)deleteSubpplementaryItemAtIndex:(NSIndexPath *)indexPath;


/**
 获取增补视图

 @param indexPath 'indexPath'
 @return 'item'
 */
- (WBCollectionSupplementaryItem *)supplementaryItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 获取添加的SupplementaryViews的所在位置，通常在自定义布局的时候可以用到
 
 @return 'indexpath of array'
 */
- (NSArray<NSIndexPath *> *)indexPathsForSupplementaryViews;

/**
 删除所有元素
 */
- (void)deleteAllElements;

@end

@interface WBCollectionViewAdapter (AutoDiffer)


/**
 在任何的更改前调用此方法，系统会记录你对如下的更改：
 1：section的增删，位置移动
 2：row的增删，位置的移动
 
 beginAutoDiffer 和 commitAutoDiffer 成对调用，且不能嵌套
 
 在调用 commitAutoDiffer 之后，会将上述更改提交，tableview会以动画的方式响应
 
 如果涉及到row和section的 reload操作，需要调用ReloadShortcut中的方法
 
 严格来讲，当你更新了数据源后，应该立即提交view显示,安全起见，方法内部会先调用 reloadDifferWithAnimation 方法， 将未提交更改的内容先提交一次
 */
- (void)beginAutoDiffer;
/**
 同 beginAutoDiffer 嵌套调用
 */
- (void)commitAutoDifferWithAnimation:(BOOL)animation;


/**
 在任何位置调用，可以将之前的更改统一提交，tableview会以动画的方式响应
 */
- (void)reloadDifferWithAnimation:(BOOL)animation;

@end

//AutoDiffer方法并不能识别出item 的内容变化 或者 section内部的footer header 追加视图的变化，
//所以在以上内容变化需要刷新的时候，请使用下面的方法
@interface WBCollectionViewAdapter (ReloadShortcut)

- (void)reloadItemAtIndex:(NSIndexPath *)indexPath
               animation:(BOOL)animation
              usingBlock:(void(^)(WBCollectionItem *item))block
               completion:(void(^)(BOOL finish))completion;

- (void)reloadItemAtIndex:(NSInteger )index
           forSectionKey:(NSString *)key
               animation:(BOOL)animation
              usingBlock:(void(^)(WBCollectionItem *item))block
               completion:(void(^)(BOOL finish))completion;

- (void)reloadSectionAtIndex:(NSInteger)index
                   animation:(BOOL)animation
                  usingBlock:(void(^)(WBCollectionSection *section))block
                  completion:(void(^)(BOOL finish))completion;

- (void)reloadSectionForKey:(NSString *)key
                  animation:(BOOL)animation
                 usingBlock:(void(^)(WBCollectionSection *section))block
                 completion:(void(^)(BOOL finish))completion;
@end
NS_ASSUME_NONNULL_END




