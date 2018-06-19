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
 代表一个行
*/
WBListKit_SUBCLASSING_RESTRICTED
@interface WBTableRow<__covariant Data> : NSObject<WBListDiffableProtocol>

/**
 row关联的数据
 */
@property (nonatomic, strong, nullable) Data data;

/**
 这一行的唯一标识，默认为对象内存地址，可以通过section对象的rowForKey:来获取row
 你需要确保此key的唯一性
 */
@property (nonatomic, copy, nullable) NSString *key;

/**
 
  reloadKey
 
  当TableView或者adapter调用如下三个方法的时候
 
  'beginAutoDiffer'
  'commitAutoDifferWithAnimation:'
  'reloadDifferWithAnimation:'
 
  如果发现一个cell的reloadkey和之前发生变化，则会自动reload这一行cell
 
  此生key可以根据row对象的数据或者其他自定义的规则来表示row是否修改过，
  没有修改过的row不会进行刷新，减少不必要的刷新和IO操作
 
  此key不影响TableView的原始reload方法
 */
@property (nonatomic, copy, nonnull) NSString *reloadKey;

/**
 在列表中的物理位置
 */
@property (nonatomic, strong, nonnull) NSIndexPath *indexPath;

/**
 在列表中的逻辑位置
 */
@property (nonatomic, assign) WBTableRowPosition position;

/**
 这个row对象的Cell类型,如果Cell类对应了一个Nib，那么会自动加载Nib
 这个Cell类型或者Nib会自动注册到TableView
 这个Cell的类名字必须以"Cell"字符串结尾，否则会crash
 */
@property (nonatomic, strong, nonnull) Class associatedCellClass;

/**
 可以通过此block返回根据row中数据计算而来的高度(通过计算frame的方式)
 如果希望使用AutoLayout，那么可以不赋值这个属性，或者返回'WBListCellHeightAutoLayout'，
 这样框架会自动使用自动布局算高，并且缓存高度。
 
 注意：目前使用frame计算高度并不会进行缓存（待优化）
 */
@property (nonatomic, copy, nullable) CGFloat(^calculateHeight)( WBTableRow  * __nonnull row);

/**
 获取某一行的高度
 */
@property (nonatomic, assign, readonly) CGFloat height;
@end
