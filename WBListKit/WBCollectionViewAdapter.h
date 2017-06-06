//
//  WBCollectionViewAdapter.h
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import "WBCollectionSectionMaker.h"
#import "WBCollectionSupplementaryItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WBListActionToControllerProtocol;

@interface WBCollectionViewAdapter : NSObject

/**
 可以在'viewWillAppear' 和 'viewDidDisappear' 中调用，用来回调item supplementaryView
 中的 'cancel' 'reload' 方法
 */
- (void)willAppear;
- (void)didDisappear;

@property (nonatomic, weak, readonly) UICollectionView *collectionView;

/**
 you should use these method to manage tableview's and datasource
 please avoid direct use collectionView's delegate and datasource property
 
 before use it, you must know why
 */
@property (nonatomic, weak) id collectionViewDataSource;

#pragma mark Section Model

/**
 get section at index
 
 @param index 'index'
 */
- (WBCollectionSectionMaker *)sectionAtIndex:(NSUInteger)index;

/**
 get section with identifier
 
 @param identifier 'identifier'
 @return section
 */
- (WBCollectionSectionMaker *)sectionForIdentifier:(NSString *)identifier;

/**
 get index of section
 
 @param maker 'sectionMaker'
 @return index
 */
- (NSUInteger)indexOfSection:(WBCollectionSectionMaker *)maker;

/**
 append section
 
 @param block 'block'
 */
- (void)addSection:(void(^)(WBCollectionSectionMaker *maker))block;

/**
 add section at index
 
 @param block 'block'
 @param index '指定位置'
 */
- (void)insertSection:(void(^)(WBCollectionSectionMaker *maker))block
              atIndex:(NSUInteger)index;

/**
 update section
 
 @param section 'section'
 @param block   'block'
 */
- (void)updateSection:(WBCollectionSection *)section
             useMaker:(void(^)(WBCollectionSectionMaker *maker))block;

/**
 更新指定位置的section
 
 @param index 'index'
 @param block 'block'
 */
- (void)updateSectionAtIndex:(NSUInteger)index
                    useMaker:(void(^)(WBCollectionSectionMaker *maker))block;


/**
 更新指定的id的section
 
 @param identifier 'identifier'
 @param block 'block'
 */
- (void)updateSectionForIdentifier:(NSString *)identifier
                          useMaker:(void(^)(WBCollectionSectionMaker *maker))block;

/**
 删除Section操作
 */
- (void)deleteSection:(WBCollectionSection *)section;
- (void)deleteSectionAtIndex:(NSUInteger)index;
- (void)deleteSectionForIdentifier:(NSString *)identifier;
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

NS_ASSUME_NONNULL_END




