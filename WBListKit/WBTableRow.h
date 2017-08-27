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
#import "WBListDiffableProtocol.h"

/** 使用AutoLayout自动计算cell高度 **/
extern const CGFloat WBListCellHeightAutoLayout;

/**
 cell的位置
 */
typedef NS_ENUM(NSInteger, WBTableRowPosition){
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
@interface WBTableRow : NSObject<WBListDiffableProtocol>

@property (nonatomic, assign) WBTableRowPosition position;

/**
 associated raw data
 */
@property (nonatomic, strong) id data;

/**
 这一行的唯一标识，默认为对象内存地址，可以通过section对象的rowForKey:来获取row
 */
@property (nonatomic, copy) NSString *key;

/**
 当reloadKey发生变化的时候，会在adapter的beginDiffer和commitDiffer的时候自动reload
 可以通过data的field自定义这个key的get方法，来达到数据源更改后，自动reload
 默认为Cell的关联Row的内存地址，如果更换了row，那么也能达到自动reload的效果
 */
@property (nonatomic, copy) NSString *reloadKey;

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
 if you don't give a block to take a height, framework will use autolayout
 or ,you can return WBListCellHeightAutoLayout to use autolayout
 */
@property (nonatomic, copy) CGFloat(^calculateHeight)(WBTableRow *row);

@end
