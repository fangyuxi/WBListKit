//
//  WBCollectionSection.h
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"
#import "WBCollectionItem.h"
#import "WBListDiffableProtocol.h"

@class WBCollectionSectionMaker;

NS_ASSUME_NONNULL_BEGIN

/**
 A Model Object For One Sectoin
 */
WBListKit_SUBCLASSING_RESTRICTED
@interface WBCollectionSection : NSObject<WBListDiffableProtocol>

/**
 此section的唯一标识符，可以通过唯一标识符准确的找到这个cell
 */
@property (nonatomic, copy) NSString *key;

/**
 行数
 */
@property (nonatomic, assign, readonly) NSUInteger itemCount;

/**
 gets
 */
- (nullable WBCollectionItem *)itemAtIndex:(NSUInteger)index;

/**
 inserts
 */
- (void)addItem:(WBCollectionItem *)item;
- (void)addItems:(NSArray<WBCollectionItem *> *)items;
- (void)insertItem:(WBCollectionItem *)item
           atIndex:(NSUInteger)index;

/**
 delete
 */
- (void)deleteItem:(WBCollectionItem *)item;
- (void)deleteItemAtIndex:(NSUInteger)index;
- (void)deleteAllItems;

/**
 exchange replace
 */
- (void)replaceItemAtIndex:(NSUInteger)index
                  withItem:(WBCollectionItem *)item;
- (void)exchangeItemAtIndex:(NSUInteger)index1
                  withIndex:(NSInteger)index2;

@end

NS_ASSUME_NONNULL_END
