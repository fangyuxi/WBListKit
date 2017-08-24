//
//  WBListSection.h
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import <Foundation/Foundation.h>
#import "WBTableRow.h"
#import "WBTableSectionHeaderFooter.h"
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"
#import "WBListDiffableProtocol.h"

NS_ASSUME_NONNULL_BEGIN

WBListKit_SUBCLASSING_RESTRICTED
@interface WBTableSection : NSObject<WBListDiffableProtocol>

/**
 gets
 */
- (nullable WBTableRow *)rowAtIndex:(NSInteger)index;
- (nullable WBTableRow *)rowForKey:(NSString *)key;

/**
 行数
 */
@property (nonatomic, assign, readonly) NSUInteger rowCount;

/**
 此section的唯一标识符
 */
@property (nonatomic, copy, readwrite) NSString *key;

/**
 footer and header
 */
@property (nonatomic, strong, nullable) WBTableSectionHeaderFooter *header;
@property (nonatomic, strong, nullable) WBTableSectionHeaderFooter *footer;

//如果设置了header，那么如下属性失效
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, strong) UIColor *headerColor;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, strong) UIColor *footerColor;

/**
 inserts
 */
- (void)addRow:(WBTableRow *)row;
- (void)addRows:(NSArray<WBTableRow *> *)rows;
- (void)insertRow:(WBTableRow *)row
          atIndex:(NSUInteger)index;

- (void)addNewRow:(void(^)(WBTableRow *row))block;

/**
 delete
 */
- (void)deleteRow:(WBTableRow *)row;
- (void)deleteRowAtIndex:(NSUInteger)index;
- (void)deleteAllRows;

/**
 exchange replace
 */
- (void)replaceRowAtIndex:(NSUInteger)index
                  withRow:(WBTableRow *)row;
- (void)exchangeRowAtIndex:(NSUInteger)index1
                 withIndex:(NSInteger)index2;

@end

NS_ASSUME_NONNULL_END







