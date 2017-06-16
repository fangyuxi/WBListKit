//
//  WBTableViewDataSource.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/29.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "UITableView+WBListKitPrivate.h"
#import "UITableView+WBListKit.h"
#import "WBTableViewDataSourcePrivate.h"
#import "WBTableViewAdapterPrivate.h"

@implementation WBTableViewDataSource

@synthesize tableViewAdapter = _tableViewAdapter;

- (void)loadSource{
}

- (void)bindTableView:(nullable UITableView *)tableView{
    self.tableViewAdapter.tableView = nil;
    self.tableView = tableView;
    self.tableView.source = self;
    self.tableView.adapter = self.tableViewAdapter;
}

- (void)unBindTableView{
    self.tableViewAdapter.tableView = nil;
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
