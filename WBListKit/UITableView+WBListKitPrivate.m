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

static int AdapterKey;
static int SourceKey;

@implementation UITableView (WBListKitPrivate)

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
