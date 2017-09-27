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

/**
 row关联的数据
 */
@property (nonatomic, strong) id data;

/**
 这一行的唯一标识，默认为对象内存地址，可以通过section对象的rowForKey:来获取row
 */
@property (nonatomic, copy) NSString *key;

/**
 当reloadKey发生变化的时候，会在adapter的beginDiffer和commitDiffer的时候自动reload
 可以通过data的field自定义这个key的get方法，来达到数据源更改后，自动reload
 默认为Cell的关联Row的内存地址，如果更换了row，那么也能达到自动reload的效果，
 
 注意：你应该确保每一个row的reloadKey不同，因为计算差异是通过reloadkey来达到目的的，
      如果出现相同的情况，会出现不可预测的问题。
 
      同key的区别，key是只要这个row创建了就不会在变化了，因为外部可能随时会通过这个key来回去row对象
                 reloadKey是可能会变化的，来提醒差异化计算改更新这条row了
 */
@property (nonatomic, copy) NSString *(^reloadKeyGenerator)(WBTableRow *row);

/**
 在列表中的物理位置
 */
@property (nonatomic, strong) NSIndexPath *indexPath;


/**
 在列表中的逻辑位置
 */
@property (nonatomic, assign) WBTableRowPosition position;

/**
 这个row对象的Cell类型,如果Cell类对应了一个Nib，那么会自动加载Nib
 这个Cell类型或者Nib会自动注册到TableView
 这个Cell的类名字必须以"Cell"字符串结尾，否则会crash
 */
@property (nonatomic, strong) Class associatedCellClass;

/**
 if you don't give a block to take a height, framework will use autolayout
 or ,you can return WBListCellHeightAutoLayout to use autolayout
 */
@property (nonatomic, copy) CGFloat(^calculateHeight)(WBTableRow *row);

@end
