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

NS_ASSUME_NONNULL_BEGIN

WBListKit_SUBCLASSING_RESTRICTED
@interface WBTableSection : NSObject

/**
 此section的唯一标识符
 */
@property (nonatomic, copy) NSString *identifier;

/**
 行数
 */
@property (nonatomic, assign, readonly) NSUInteger rowCount;


/**
 footer and header
 */
@property (nonatomic, strong, nullable) WBTableSectionHeaderFooter *header;
@property (nonatomic, strong, nullable) WBTableSectionHeaderFooter *footer;

/**
 gets
 */
- (nullable __kindof WBTableRow *)rowAtIndex:(NSUInteger)index;

/**
 inserts
 */
- (void)addRow:(__kindof WBTableRow *)row;
- (void)addRows:(NSArray<__kindof WBTableRow *> *)rows;
- (void)insertRow:(__kindof WBTableRow *)row
          atIndex:(NSUInteger)index;

/**
 delete
 */
- (void)deleteRow:(__kindof WBTableRow *)row;
- (void)deleteRowAtIndex:(NSUInteger)index;
- (void)deleteAllRows;

/**
 exchange replace
 */
- (void)replaceRowAtIndex:(NSUInteger)index
                   withRow:(__kindof WBTableRow *)row;
- (void)exchangeRowAtIndex:(NSUInteger)index1
                 withIndex:(NSInteger)index2;
@end

NS_ASSUME_NONNULL_END







