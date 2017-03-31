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

/**
 A Model for UICollectionView Cell
 */
WBListKit_SUBCLASSING_RESTRICTED
@interface WBCollectionItem : NSObject

/**
 associated item data
 */
@property (nonatomic, strong, nullable) id data;

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
