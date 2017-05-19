//
//  WBMultiSourceController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/29.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBMultiSourceController.h"
#import "WBLeftTableSource.h"
#import "WBRightTableSource.h"

@interface WBMultiSourceController ()<WBListActionToControllerProtocol>

@property (nonatomic, strong) WBLeftTableSource *leftSource;
@property (nonatomic, strong) WBRightTableSource *rightSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WBMultiSourceController

- (void)viewDidLoad{
    [super viewDidLoad];

    [self createView];
    [self createSource];
    [self changeTableVieSource];
}

- (void)createView{
    
    //tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.actionDelegate = self;
    [self.view addSubview:self.tableView];
    
    //header
    MJRefreshStateHeader *header = [[MJRefreshStateHeader alloc] init];
    
    self.list.refreshHeaderView = header;
    self.list.tableView = self.tableView;
}

- (void)createSource{
    self.leftSource = [[WBLeftTableSource alloc] initWithDelegate:self];
    self.rightSource = [[WBRightTableSource alloc] initWithDelegate:self];
}

- (void)changeTableVieSource{
    if (self.list.tableDataSource == self.leftSource) {
        self.list.tableDataSource = self.rightSource;
    }else if (self.list.tableDataSource == self.rightSource){
        self.list.tableDataSource = self.leftSource;
    }else{
        self.list.tableDataSource = self.leftSource;
    }
    
    [self.tableView bindViewDataSource:self.list.tableDataSource];
    [self.list refreshImmediately];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self changeTableVieSource];
}

@end
