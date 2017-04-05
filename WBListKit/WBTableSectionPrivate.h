//
//  WBTableSectionPrivate.h
//  Pods
//
//  Created by 58 on 2017/4/2.
//
//

#ifndef WBTableSectionPrivate_h
#define WBTableSectionPrivate_h
@class WBTableSection;

@interface WBTableSection ()

@property (nonatomic, strong, nullable, readwrite) WBTableSectionMaker *maker;

/**
 此section的唯一标识符
 */
@property (nonatomic, copy, readwrite) NSString *identifier;

/**
 行数
 */
@property (nonatomic, assign, readwrite) NSUInteger rowCount;


/**
 footer and header
 */
@property (nonatomic, strong, nullable, readwrite) WBTableSectionHeaderFooter *header;
@property (nonatomic, strong, nullable, readwrite) WBTableSectionHeaderFooter *footer;

/**
 inserts
 */
- (void)addRow:(WBTableRow *)row;
- (void)addRows:(NSArray<WBTableRow *> *)rows;
- (void)insertRow:(WBTableRow *)row
          atIndex:(NSUInteger)index;

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

#endif /* WBTableSectionPrivate_h */
