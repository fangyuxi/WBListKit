//
//  WBCollectionSection.h
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"
#import "WBCollectionItem.h"

@class WBCollectionSectionMaker;

NS_ASSUME_NONNULL_BEGIN

/**
 A Model Object For One Sectoin
 */
WBListKit_SUBCLASSING_RESTRICTED
@interface WBCollectionSection : NSObject

@property (nonatomic, strong, nullable, readonly) WBCollectionSectionMaker *maker;

/**
 此section的唯一标识符，可以通过唯一标识符准确的找到这个cell
 */
@property (nonatomic, copy, readonly) NSString *identifier;

/**
 行数
 */
@property (nonatomic, assign, readonly) NSUInteger itemCount;

/**
 gets
 */
- (nullable WBCollectionItem *)itemAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
