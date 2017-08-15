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

@class WBTableSectionMaker;

NS_ASSUME_NONNULL_BEGIN

WBListKit_SUBCLASSING_RESTRICTED
@interface WBTableSection : NSObject<WBListDiffableProtocol>

/**
 gets
 */
- (nullable WBTableRow *)rowAtIndex:(NSUInteger)index;

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







