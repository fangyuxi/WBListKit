//
//  WBCollectionSectionMaker.h
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import "WBCollectionSection.h"
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"

/**
 实现链式语法
 **/

NS_ASSUME_NONNULL_BEGIN

WBListKit_SUBCLASSING_RESTRICTED
@interface WBCollectionSectionMaker : NSObject

@property (nonatomic, strong, readonly) WBCollectionSection *section;


/**
 创建SectionMaker
 
 @param section 'section'
 @return 'maker'
 */
- (instancetype)initWithSection:(WBCollectionSection *)section NS_DESIGNATED_INITIALIZER;

- (instancetype)init WBListKit_UNAVAILABLE("Must have a section");
- (instancetype)new  WBListKit_UNAVAILABLE("Must have a section");

/**
 链式语法的连词
 
 @return self
 */
- (WBCollectionSectionMaker *)and;


/**
 row count
 
 @return 'count'
 */
- (NSUInteger)itemsCount;

/**
 *  设置section的唯一标识符
 *
 */
- (WBCollectionSectionMaker *(^)(NSString *identifier))setIdentifier;

/**
 *  返回一行
 */
- (WBCollectionItem *(^)(NSUInteger index))itemAtIndex;

/**
 *  追加一行 返回该行的RowMaker
 */
- (WBCollectionSectionMaker *(^)(WBCollectionItem *row))addItem;

/**
 *  在指定位置插入一行 返回该行的RowMaker
 */
- (WBCollectionSectionMaker *(^)(WBCollectionItem *item, NSUInteger index))insertItem;

/**
 *  追加多行
 */
- (WBCollectionSectionMaker *(^)(NSArray *items))addItems;

/**
 *  替换一行 返回新的一行的RowMaker
 */
- (WBCollectionSectionMaker *(^)(WBCollectionItem *item, NSUInteger index))replaceItem;

/**
 *  交换两行
 */
- (WBCollectionSectionMaker *(^)(NSUInteger idx1, NSUInteger idx2))exchangeItem;

/**
 *  删除操作
 */
- (WBCollectionSectionMaker *(^)(NSUInteger index))deleteItemAtIndex;
- (WBCollectionSectionMaker *(^)(WBCollectionItem *item))deleteItem;
- (WBCollectionSectionMaker *(^)())deleteAllItems;

@end

NS_ASSUME_NONNULL_END
