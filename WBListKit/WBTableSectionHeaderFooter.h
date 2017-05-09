//
//  WBListSectionHeaderFooter.h
//  Pods
//
//  Created by fangyuxi on 2017/3/20.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"

/** 使用AutoLayout自动计算高度 **/
extern const CGFloat WBTableHeaderFooterHeightAutoLayout;

/**
 类型
 */
typedef NS_ENUM(NSInteger, WBTableHeaderFooterType)
{
    WBTableHeaderFooterTypeHeader = 1,
    WBTableHeaderFooterTypeFooter
};


/**
 A 'Model Object' for header & footer
 */
WBListKit_SUBCLASSING_RESTRICTED
@interface WBTableSectionHeaderFooter : NSObject

@property (nonatomic, assign) WBTableHeaderFooterType displayType;

/**
 associated raw data
 */
@property (nonatomic, strong) id data;

/**
  class name will be used as reuseIditifier
  class or nib will be automatically registed in tableview by kit
  for standard, the cell name must ended in 'header or footer' like HYCustomHeader,otherwise will crash
 */
@property (nonatomic, strong) Class associatedHeaderFooterClass;

/**
 default is WBListHeaderFooterHeightAutoLayout
 */
@property (nonatomic, assign) CGFloat height;

/**
 if height is WBListHeaderFooterHeightAutoLayout
 then calculateHeight will never be called
 */
@property (nonatomic, copy) CGFloat(^calculateHeight)(WBTableSectionHeaderFooter *headerFooter);

/**
 if height is WBListCellHeightAutoLayout
 then updateHeight() will never effect height
 you could use view layout method ,like 'updateConstraints()' instead
 */
- (void)updateHeight;


@end
