//
//  WBReformerListViewController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBReformerListViewController.h"
#import "WBListKit.h"
#import "WBReformerListCell.h"
#import "WBReformerListCellReformer.h"

@interface WBReformerListViewController ()

@property (nonatomic, strong) WBTableViewAdapter *adapter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WBReformerListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.title = @"Reformer List";
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.adapter = [[WBTableViewAdapter alloc] init];
    [self.adapter bindTableView:self.tableView];
    
    [self loadData];
}

- (void)loadData{
    
    [self.adapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
        
        for (NSInteger index = 0; index < 5; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            row.calculateHeight = ^CGFloat(WBTableRow *row){
                return 60.0f;
            };
            row.associatedCellClass = [WBReformerListCell class];
            WBReformerListCellReformer *reformer = [WBReformerListCellReformer new];
            [reformer reformRawData:@{@"title":@(index),
                                      @"date":[NSDate new]
                                      } forRow:row];
            row.data = reformer;
            maker.addRow(row);
        }
    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [self.tableView reloadData];
//        });
//    });
}

@end
