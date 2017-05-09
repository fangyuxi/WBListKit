//
//  WBCollectionSectionPrivate.h
//  Pods
//
//  Created by fangyuxi on 2017/4/5.
//
//

#ifndef WBCollectionSectionPrivate_h
#define WBCollectionSectionPrivate_h

#import "WBCollectionSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBCollectionSection ()

@property (nonatomic, strong, nullable, readwrite) WBCollectionSectionMaker *maker;

/**
 此section的唯一标识符
 */
@property (nonatomic, copy, readwrite) NSString *identifier;

/**
 行数
 */
@property (nonatomic, assign, readwrite) NSUInteger itemCount;

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

#endif /* WBCollectionSectionPrivate_h */
