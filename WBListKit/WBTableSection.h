//
//  WBListSection.h
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import <Foundation/Foundation.h>
#import "WBTableRow.h"
#import "WBTableSectionHeaderFooter.h"
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"
#import "WBListDiffableProtocol.h"

@class WBTableSectionMaker;



NS_ASSUME_NONNULL_BEGIN

WBListKit_SUBCLASSING_RESTRICTED
@interface WBTableSection : NSObject<WBListDiffableProtocol>

/**
 use a maker to config section
 */
@property (nonatomic, strong, nullable, readonly) WBTableSectionMaker *maker;

/**
 此section的唯一标识符
 */
@property (nonatomic, copy, readonly) NSString *identifier;

/**
 行数
 */
@property (nonatomic, assign, readonly) NSUInteger rowCount;


/**
 footer and header
 */
@property (nonatomic, strong, nullable, readonly) WBTableSectionHeaderFooter *header;
@property (nonatomic, strong, nullable, readonly) WBTableSectionHeaderFooter *footer;

/**
 gets
 */
- (nullable WBTableRow *)rowAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END







