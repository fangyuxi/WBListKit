//
//  UITableView+WBSizeManager.m
//  WBListKit
//
//  Created by fangyuxi on 2019/2/25.
//

#import "UITableView+WBHeightCache.h"
#import <objc/runtime.h>
#import "WBListKitMacros.h"

@implementation UITableView(WBHeightCache)

- (WBTableViewHeightCache *)wb_indexPathHeightCache {
    WBTableViewHeightCache *cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [WBTableViewHeightCache new];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}

- (void)wb_reloadDataWithoutInvalidateIndexPathHeightCache {
    WBLISTPrimaryCall([self wb_reloadData];);
}

+ (void)load {
    // All methods that trigger height cache's invalidation
    SEL selectors[] = {
        @selector(reloadData),
        @selector(insertSections:withRowAnimation:),
        @selector(deleteSections:withRowAnimation:),
        @selector(reloadSections:withRowAnimation:),
        @selector(moveSection:toSection:),
        @selector(insertRowsAtIndexPaths:withRowAnimation:),
        @selector(deleteRowsAtIndexPaths:withRowAnimation:),
        @selector(reloadRowsAtIndexPaths:withRowAnimation:),
        @selector(moveRowAtIndexPath:toIndexPath:)
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"wb_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)wb_reloadData {
    [self.wb_indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WBIndexPathHeightsBySection *heightsBySection) {
        [heightsBySection removeAllObjects];
    }];
    WBLISTPrimaryCall([self wb_reloadData];);
}

- (void)wb_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL *stop) {
        [self.wb_indexPathHeightCache buildSectionsIfNeeded:section];
        [self.wb_indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WBIndexPathHeightsBySection *heightsBySection) {
            [heightsBySection insertObject:[NSMutableArray array] atIndex:section];
        }];
    }];
    WBLISTPrimaryCall([self wb_insertSections:sections withRowAnimation:animation];);
}

- (void)wb_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL *stop) {
        [self.wb_indexPathHeightCache buildSectionsIfNeeded:section];
        [self.wb_indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WBIndexPathHeightsBySection *heightsBySection) {
            [heightsBySection removeObjectAtIndex:section];
        }];
    }];
    WBLISTPrimaryCall([self wb_deleteSections:sections withRowAnimation:animation];);
}

- (void)wb_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [sections enumerateIndexesUsingBlock: ^(NSUInteger section, BOOL *stop) {
        [self.wb_indexPathHeightCache buildSectionsIfNeeded:section];
        [self.wb_indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WBIndexPathHeightsBySection *heightsBySection) {
            [heightsBySection[section] removeAllObjects];
        }];
        
    }];
    WBLISTPrimaryCall([self wb_reloadSections:sections withRowAnimation:animation];);
}

- (void)wb_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    [self.wb_indexPathHeightCache buildSectionsIfNeeded:section];
    [self.wb_indexPathHeightCache buildSectionsIfNeeded:newSection];
    [self.wb_indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WBIndexPathHeightsBySection *heightsBySection) {
        [heightsBySection exchangeObjectAtIndex:section withObjectAtIndex:newSection];
    }];
    WBLISTPrimaryCall([self wb_moveSection:section toSection:newSection];);
}

- (void)wb_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.wb_indexPathHeightCache buildCachesAtIndexPathsIfNeeded:indexPaths];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        [self.wb_indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WBIndexPathHeightsBySection *heightsBySection) {
            [heightsBySection[indexPath.section] insertObject:@-1 atIndex:indexPath.row];
        }];
    }];
    WBLISTPrimaryCall([self wb_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];);
}

- (void)wb_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.wb_indexPathHeightCache buildCachesAtIndexPathsIfNeeded:indexPaths];
    
    NSMutableDictionary<NSNumber *, NSMutableIndexSet *> *mutableIndexSetsToRemove = [NSMutableDictionary dictionary];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        NSMutableIndexSet *mutableIndexSet = mutableIndexSetsToRemove[@(indexPath.section)];
        if (!mutableIndexSet) {
            mutableIndexSet = [NSMutableIndexSet indexSet];
            mutableIndexSetsToRemove[@(indexPath.section)] = mutableIndexSet;
        }
        [mutableIndexSet addIndex:indexPath.row];
    }];
    
    [mutableIndexSetsToRemove enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSIndexSet *indexSet, BOOL *stop) {
        [self.wb_indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WBIndexPathHeightsBySection *heightsBySection) {
            [heightsBySection[key.integerValue] removeObjectsAtIndexes:indexSet];
        }];
    }];
    WBLISTPrimaryCall([self wb_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];);
}

- (void)wb_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.wb_indexPathHeightCache buildCachesAtIndexPathsIfNeeded:indexPaths];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        [self.wb_indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WBIndexPathHeightsBySection *heightsBySection) {
            heightsBySection[indexPath.section][indexPath.row] = @-1;
        }];
    }];
    WBLISTPrimaryCall([self wb_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];);
}

- (void)wb_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.wb_indexPathHeightCache buildCachesAtIndexPathsIfNeeded:@[sourceIndexPath, destinationIndexPath]];
    [self.wb_indexPathHeightCache enumerateAllOrientationsUsingBlock:^(WBIndexPathHeightsBySection *heightsBySection) {
        NSMutableArray<NSNumber *> *sourceRows = heightsBySection[sourceIndexPath.section];
        NSMutableArray<NSNumber *> *destinationRows = heightsBySection[destinationIndexPath.section];
        NSNumber *sourceValue = sourceRows[sourceIndexPath.row];
        NSNumber *destinationValue = destinationRows[destinationIndexPath.row];
        sourceRows[sourceIndexPath.row] = destinationValue;
        destinationRows[destinationIndexPath.row] = sourceValue;
    }];
    WBLISTPrimaryCall([self wb_moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];);
}

@end
