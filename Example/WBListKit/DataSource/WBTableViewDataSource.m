//
//  WBTableViewDataSource.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/29.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBTableViewDataSource.h"

@interface WBTableViewDataSource ()

/**
 display data on whitch
 set this property to bind tableview on this datasource
 */
@property (nonatomic, weak, readwrite, nullable) UITableView *tableView;

@end

@implementation WBTableViewDataSource

@synthesize tableViewAdapter = _tableViewAdapter;
@synthesize actionDelegate = _actionDelegate;

- (void)bindTableView:(nullable UITableView *)tableView{
    [self.tableViewAdapter unBindTableView];
    self.tableView = tableView;
    if (tableView) {
        [self.tableViewAdapter bindTableView:self.tableView];
    }
    if (self.actionDelegate) {
        self.tableViewAdapter.actionDelegate = self.actionDelegate;
    }
}

- (void)unBindTableView{
    [self.tableViewAdapter unBindTableView];
    self.tableView = nil;
}

- (WBTableViewAdapter *)tableViewAdapter{
    if (!_tableViewAdapter) {
        _tableViewAdapter = [WBTableViewAdapter new];
    }
    return _tableViewAdapter;
}

//- (void)setActionDelegate:(id<WBListActionToControllerProtocol>)actionDelegate{
//    _actionDelegate = actionDelegate;
//    self.tableViewAdapter.tableDelegate = _actionDelegate;
//}

@end
