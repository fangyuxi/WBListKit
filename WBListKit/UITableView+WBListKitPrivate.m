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

@implementation UITableView (WBListKitPrivate)

+ (void)load {
    SEL selectors[] = {
        @selector(reloadData)
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
    [self wblist_reloadData];
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
