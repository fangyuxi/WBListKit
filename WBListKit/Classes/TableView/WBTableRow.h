//
//  WBTableRow.h
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"

/** 使用AutoLayout自动计算cell高度 **/
extern const CGFloat WBListCellHeightAutoLayout;

/**
 cell的位置
 */
typedef NS_ENUM(NSInteger, WBTableRowPosition)
{
    WBTableRowPositionDefault,
    WBTableRowPositionTop,
    WBTableRowPositionMiddle,
    WBTableRowPositionBottom,
    WBTableRowPositionSingle,
};

/**
 A 'Model Object' for cell
 */

WBListKit_SUBCLASSING_RESTRICTED
@interface WBTableRow : NSObject

@property (nonatomic, assign) WBTableRowPosition position;

/**
 associated raw data
 */
@property (nonatomic, strong) id data;

/**
 location in list
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 cell class name will be used as reuseIditifier
 cell class or nib will be automatically registed in tableview by kit
 for standard, the cell name must ended in 'cell' like HYCustomCell,otherwise will crash
 */
@property (nonatomic, strong) Class associatedCellClass;

/**
 default is WBListCellHeightAutoLayout
 */
@property (nonatomic, assign) CGFloat height;

/**
 if cellHeight is WBListCellHeightAutoLayout
 then calculateCellHeight will never be called
 */
@property (nonatomic, copy) CGFloat(^calculateHeight)(WBTableRow *row);

/**
 if cellHeight is WBListCellHeightAutoLayout
 then updateCellHeight() will never effect height
 you could use view layout method ,like 'updateConstraints()' instead
 */
- (void)updateHeight;

@end
