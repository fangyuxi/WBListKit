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
@interface WBCollectionItem : NSObject<WBListDiffableProtocol>

/**
 associated item data
 */
@property (nonatomic, strong, nullable) id data;

/**
 这一行的唯一标识，默认为对象内存地址
 */
@property (nonatomic, copy, nullable) NSString *key;

/**
 location in list
 */
@property (nonatomic, strong, nonnull) NSIndexPath *indexPath;

/**
 cell class name will be used as reuseIditifier
 cell class or nib will be automatically registed in tableview by kit
 for standard, the cell name must ended in 'cell' like HYCustomCell,otherwise will crash
 */
@property (nonatomic, strong, nonnull) Class associatedCellClass;

@end
