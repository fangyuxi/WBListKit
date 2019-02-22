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
