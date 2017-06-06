//
//  WBMVCViewController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/24.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBMVCViewController.h"
#import "WBListKit.h"
#import "WBMVCTableListDataSource.h"
#import "WBMVCRefreshHeader.h"
#import "WBMVCRefreshFooter.h"

@interface WBMVCViewController ()<WBListActionToControllerProtocol>

@end

@implementation WBMVCViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self createView];
    self.list.tableDataSource = [[WBMVCTableListDataSource alloc] initWithDelegate:self];
    [self.list.tableView bindViewDataSource:self.list.tableDataSource];
    
    [self.list refreshImmediately];
}

- (void)createView{
    WBMVCRefreshHeader *header = [[WBMVCRefreshHeader alloc] init];
    self.list.refreshHeaderView = header;
    
    self.list.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.list.tableView];
    
    WBMVCRefreshFooter *footer = [[WBMVCRefreshFooter alloc] init];
    self.list.loadMoreFooterView = footer;
}


/** 如果想使用代理，那么必须调用super **/
- (void)sourceDidStartLoad:(WBListDataSource *)tableSource{
    [super sourceDidStartLoad:tableSource];
}

- (void)actionFromReusableView:(UIView *)view eventTag:(NSString *)tag parameter:(id)param{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
