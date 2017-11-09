//
//  WBCollectionSupplementaryItem.h
//  Pods
//
//  Created by fangyuxi on 2017/4/1.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"

NS_ASSUME_NONNULL_BEGIN
/**
 A Model for Supplementary View
 */
WBListKit_SUBCLASSING_RESTRICTED
@interface WBCollectionSupplementaryItem<__covariant Data> : NSObject

/**
 associated item data
 */
@property (nonatomic, strong, nullable) Data data;

/**
 location in list
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 cell class name will be used as reuseIditifier
 cell class or nib will be automatically registed in tableview by kit
 */
@property (nonatomic, strong) Class associatedViewClass;

/**
 SupplementaryView's Kind String
 */
@property (nonatomic, strong) NSString *elementKind;

@end

NS_ASSUME_NONNULL_END
