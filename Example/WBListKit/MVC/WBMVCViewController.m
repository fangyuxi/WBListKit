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
    MJRefreshStateHeader *header = [[MJRefreshStateHeader alloc] init];
    self.list.refreshHeaderView = header;
    
    self.list.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.list.tableView];
    
    MJRefreshAutoFooter *footer = [[MJRefreshAutoFooter alloc] init];
    self.list.loadMoreFooterView = footer;
}

- (void)sourceDidStartLoad:(WBListDataSource *)tableSource{
}

- (void)actionFromReusableView:(UIView *)view
                  withEventTag:(NSString *)tag
           withParameterObject:(id)object{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
