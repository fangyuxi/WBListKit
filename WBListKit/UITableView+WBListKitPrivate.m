//
//  UITableView+WBListKitPrivate.m
//  Pods
//
//  Created by Romeo on 2017/5/16.
//
//

#import "UITableView+WBListKitPrivate.h"
#import <objc/runtime.h>
#import "UITableView+WBListKit.h"
#import "WBTableViewAdapterPrivate.h"
#import "WBTableViewDataSource.h"
#import "WBTableSectionPrivate.h"

static int AdapterKey;
static int SourceKey;

// We just forward primary call, in crash report, top most method in stack maybe WBLIST's,
// but it's really not our bug, you should check whether your table view's data source and
// displaying cells are not matched when reloading.
static void __WBLIST_TEMPLATE_LAYOUT_CELL_PRIMARY_CALL_IF_CRASH_NOT_OUR_BUG__(void (^callout)(void)) {
    callout();
}
#define WBLISTPrimaryCall(...) do {__WBLIST_TEMPLATE_LAYOUT_CELL_PRIMARY_CALL_IF_CRASH_NOT_OUR_BUG__(^{__VA_ARGS__});} while(0)

@implementation UITableView (WBListKitPrivate)

+ (void)load {
    SEL selectors[] = {
        @selector(reloadData),
        @selector(reloadSections:withRowAnimation:)
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"wblist_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
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

- (void)setAdapter:(WBTableViewAdapter *)adapter{
    objc_setAssociatedObject(self, &AdapterKey, adapter, OBJC_ASSOCIATION_ASSIGN);
    adapter.actionDelegate = self.actionDelegate;
}

- (WBTableViewAdapter *)adapter{
   return objc_getAssociatedObject(self, &AdapterKey);
}

- (void)setSource:(WBTableViewDataSource *)source{
    objc_setAssociatedObject(self, &SourceKey, source, OBJC_ASSOCIATION_ASSIGN);
}

- (WBTableViewDataSource *)source{
    return objc_getAssociatedObject(self, &SourceKey);
}

@end
