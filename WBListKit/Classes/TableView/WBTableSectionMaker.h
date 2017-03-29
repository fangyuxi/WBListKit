//
//  .h
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import <Foundation/Foundation.h>
#import "WBTableSection.h"
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"

/**
    实现链式语法
 **/

NS_ASSUME_NONNULL_BEGIN

WBListKit_SUBCLASSING_RESTRICTED
@interface  WBTableSectionMaker : NSObject

@property (nonatomic, strong, readonly) WBTableSection *section;


/**
    创建SectionMaker

    @param section 'section'
    @return 'maker'
 */
- (instancetype)initWithSection:(WBTableSection *)section NS_DESIGNATED_INITIALIZER;

- (instancetype)init WBListKit_UNAVAILABLE("Must have a section");
- (instancetype)new  WBListKit_UNAVAILABLE("Must have a section");


/**
    链式语法的连词

    @return self
 */
- (WBTableSectionMaker *)and;


/**
    row count

    @return 'count'
 */
- (NSUInteger)rowCount;

/**
 *  设置section的唯一标识符
 *
 */
- (WBTableSectionMaker *(^)(NSString *identifier))setIdentifier;

/**
 *  返回一行
 */
- (WBTableRow *(^)(NSUInteger index))rowAtIndex;

/**
 *  追加一行 返回该行的RowMaker
 */
- (WBTableSectionMaker *(^)(WBTableRow *row))addRow;

/**
 *  在指定位置插入一行 返回该行的RowMaker
 */
- (WBTableSectionMaker *(^)(WBTableRow *row, NSUInteger index))insertRow;

/**
 *  追加多行
 */
- (WBTableSectionMaker *(^)(NSArray *rows))addRows;

/**
 *  替换一行 返回新的一行的RowMaker
 */
- (WBTableSectionMaker *(^)(WBTableRow *row, NSUInteger index))replaceRow;

/**
 *  交换两行
 */
- (WBTableSectionMaker *(^)(NSUInteger idx1, NSUInteger idx2))exchangeRow;

/**
 *  删除操作
 */
- (WBTableSectionMaker *(^)(NSUInteger index))deleteRowAtIndex;
- (WBTableSectionMaker *(^)(WBTableRow *row))deleteRow;
- (WBTableSectionMaker *(^)())deleteAllRows;

/**
 *  footer header 'pass nil to delete footer or header'
 */
- (WBTableSectionMaker *(^)( WBTableSectionHeaderFooter * _Nullable header))addHeader;
- (WBTableSectionMaker *(^)( WBTableSectionHeaderFooter * _Nullable footer))addFooter;

@end

NS_ASSUME_NONNULL_END


