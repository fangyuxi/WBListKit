//
//  UITableView+WBListKit.m
//  Pods
//
//  Created by Romeo on 2017/5/15.
//
//

#import "UITableView+WBListKit.h"
#import "UITableView+WBListKitPrivate.h"
#import <objc/runtime.h>
#import "WBListReusableViewProtocol.h"
#import "WBTableViewAdapterPrivate.h"
#import "WBTableViewDataSource.h"
#import "WBTableViewDataSourcePrivate.h"

static int AdapterKey;
static int DataSourceKey;
static int WBListActionToControllerProtocolKey;

@implementation UITableView (WBListKit)

#pragma getters setters

- (void)setActionDelegate:(id<WBListActionToControllerProtocol>)actionDelegate{
    objc_setAssociatedObject(self, &WBListActionToControllerProtocolKey, actionDelegate, OBJC_ASSOCIATION_ASSIGN);
    self.adapter.actionDelegate = actionDelegate;
}

- (id<WBListActionToControllerProtocol>)actionDelegate{
    return objc_getAssociatedObject(self, &WBListActionToControllerProtocolKey);
}

- (void)setTableDataSource:(id)tableDataSource{
    objc_setAssociatedObject(self, &DataSourceKey, tableDataSource, OBJC_ASSOCIATION_ASSIGN);
    self.adapter.tableDataSource = tableDataSource;
}

- (id)tableDataSource{
    return objc_getAssociatedObject(self, &DataSourceKey);
}

- (void)setAdapter:(WBTableViewAdapter *)adapter{
    
    objc_setAssociatedObject(self, &AdapterKey, adapter, OBJC_ASSOCIATION_ASSIGN);
    adapter.tableView = self;
    adapter.actionDelegate = self.actionDelegate;
}

- (WBTableViewAdapter *)adapter{
    
    WBTableViewAdapter *adapter = objc_getAssociatedObject(self, &AdapterKey);
    NSAssert(adapter, @"WBListKit: You should set adapter for your tableView");
    return adapter;
}

#pragma mark appear disappear

- (void)willAppear{
    [self.adapter willAppear];
}

- (void)didDisappear{
    [self.adapter didDisappear];
}

#pragma mark bind view source

- (void)bindViewDataSource:(nonnull WBTableViewDataSource *)source{
    [self unbindViewDataSource];
    [source bindTableView:self];
    [self reloadData];
}

- (void)unbindViewDataSource{
    [self.source unBindTableView];
}

#pragma mark differ

- (void)beginAutoDiffer{
    [self.adapter beginAutoDiffer];
}
- (void)commitAutoDifferWithAnimation:(BOOL)animation{
    [self.adapter commitAutoDifferWithAnimation:animation];
}
- (void)reloadDifferWithAnimation:(BOOL)animation{
    [self.adapter reloadDifferWithAnimation:animation];
}

@end
