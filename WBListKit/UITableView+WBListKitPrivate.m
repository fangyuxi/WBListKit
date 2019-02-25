//
//  UITableView+WBListKitPrivate.m
//  Pods
//
//  Created by fangyuxi on 2017/5/16.
//
//

#import "UITableView+WBListKitPrivate.h"
#import <objc/runtime.h>
#import "UITableView+WBListKit.h"
#import "WBTableViewAdapterPrivate.h"
#import "WBTableViewDataSource.h"
#import "WBTableSectionPrivate.h"

static int SourceKey;

@implementation UITableView (WBListKitPrivate)

+ (void)load {
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
        SEL swizzledSelector = NSSelectorFromString([@"wblist_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)setSource:(WBTableViewDataSource *)source{
    objc_setAssociatedObject(self, &SourceKey, source, OBJC_ASSOCIATION_ASSIGN);
}

- (WBTableViewDataSource *)source{
    return objc_getAssociatedObject(self, &SourceKey);
}

- (void)wblist_reloadData {
    [self.adapter resetAllSectionsAndRowsRecords];
    WBLISTPrimaryCall([self wblist_reloadData];);
}

- (void)wblist_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        WBTableSection *sectionObject = [self.adapter sectionAtIndex:idx];
        [sectionObject resetOldArray];
    }];
    WBLISTPrimaryCall([self wblist_reloadSections:sections withRowAnimation:animation];);
}

- (void)wblist_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self.adapter resetAllSectionsAndRowsRecords];
    WBLISTPrimaryCall([self wblist_insertSections:sections withRowAnimation:animation];);
}

- (void)wblist_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self.adapter resetAllSectionsAndRowsRecords];
    WBLISTPrimaryCall([self wblist_deleteSections:sections withRowAnimation:animation];);
}

- (void)wblist_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    [self.adapter resetAllSectionsAndRowsRecords];
    WBLISTPrimaryCall([self wblist_moveSection:section toSection:newSection];);
}

- (void)wblist_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.adapter resetAllSectionsAndRowsRecords];
    WBLISTPrimaryCall([self wblist_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];);
}

- (void)wblist_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.adapter resetAllSectionsAndRowsRecords];
    WBLISTPrimaryCall([self wblist_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];);
}

- (void)wblist_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self.adapter resetAllSectionsAndRowsRecords];
    WBLISTPrimaryCall([self wblist_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];);
}

- (void)wblist_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.adapter resetAllSectionsAndRowsRecords];
    WBLISTPrimaryCall([self wblist_moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];);
}


@end
