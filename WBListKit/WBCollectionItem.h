//
//  WBCollectionItem.h
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"
#import "WBListDiffableProtocol.h"

/**
 A Model for UICollectionView Cell
 */
WBListKit_SUBCLASSING_RESTRICTED
@interface WBCollectionItem<__covariant Data> : NSObject<WBListDiffableProtocol>

/**
 associated item data
 */
@property (nonatomic, strong, nullable) Data data;

/**
 这一行的唯一标识，默认为对象内存地址
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
 location in list
 */
@property (nonatomic, strong, nonnull) NSIndexPath *indexPath;

/**
 这个row对象的Cell类型,如果Cell类对应了一个Nib，那么会自动加载Nib
 这个Cell类型或者Nib会自动注册到TableView
 这个Cell的类名字必须以"Cell"字符串结尾，否则会crash
 */
@property (nonatomic, strong, nonnull) Class associatedCellClass;

@end
