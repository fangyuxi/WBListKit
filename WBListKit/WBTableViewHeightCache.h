//
//  WBTableViewHeightCache.h
//  WBListKit
//
//  Created by fangyuxi on 2019/2/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSMutableArray<NSMutableArray<NSNumber *> *> WBIndexPathHeightsBySection;

@interface WBTableViewHeightCache : NSObject

- (BOOL)existsHeightAtIndexPath:(NSIndexPath *)indexPath;
- (void)cacheHeight:(CGFloat)height byIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;
- (void)invalidateHeightAtIndexPath:(NSIndexPath *)indexPath;
- (void)invalidateAllHeightCache;

- (void)buildSectionsIfNeeded:(NSInteger)targetSection;
- (void)buildCachesAtIndexPathsIfNeeded:(NSArray *)indexPaths;
- (void)enumerateAllOrientationsUsingBlock:(void (^)(WBIndexPathHeightsBySection *heightsBySection))block;

@end

NS_ASSUME_NONNULL_END
