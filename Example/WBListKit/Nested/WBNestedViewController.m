//
//  WBNestedViewController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/4/5.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBNestedViewController.h"
#import "WBNestedTableViewCell.h"
#import "WBListKit.h"


@interface WBNestedViewController ()<WBListActionToControllerProtocol>

@property (nonatomic, strong) WBTableViewAdapter *adapter;
@property (nonatomic, strong) UITableView *tableView;

@end

@interface WBNestedViewController ()

@end

@implementation WBNestedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Nested List";
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.adapter = [[WBTableViewAdapter alloc] init];
    [self.adapter bindTableView:self.tableView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData{
    
    [self.adapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
        
        for (NSInteger index = 0; index < 500; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            row.calculateHeight = ^CGFloat(WBTableRow *row){
                return 50.0f;
            };
            row.associatedCellClass = [WBNestedTableViewCell class];
            row.data = @{@"title":@(index)
                         };
            maker.addRow(row).setIdentifier(@"FixedHeight");
        }
    }];
    
    [self.tableView reloadData];
}


@end
