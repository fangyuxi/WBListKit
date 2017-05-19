//
//  WBTableViewDataSource.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/29.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBTableViewDataSource.h"
#import "UITableView+WBListKitPrivate.h"
#import "WBTableViewDataSourcePrivate.h"
#import "WBTableViewAdapterPrivate.h"

@implementation WBTableViewDataSource

@synthesize tableViewAdapter = _tableViewAdapter;

- (void)bindTableView:(nullable UITableView *)tableView{
    [self.tableViewAdapter unBindTableView];
    self.tableView = tableView;
    self.tableView.source = self;
    if (tableView) {
        [self.tableViewAdapter bindTableView:self.tableView];
    }
}

- (void)unBindTableView{
    [self.tableViewAdapter unBindTableView];
    self.tableView.source = nil;
    self.tableView = nil;
}

- (WBTableViewAdapter *)tableViewAdapter{
    if (!_tableViewAdapter) {
        _tableViewAdapter = [WBTableViewAdapter new];
    }
    return _tableViewAdapter;
}

@end
