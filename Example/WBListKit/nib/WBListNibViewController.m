//
//  WBListNibViewController.m
//  WBListKit
//
//  Created by Romeo on 2017/6/9.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBListNibViewController.h"
#import "WBListKit.h"
#import "WBListNibCell.h"

@interface WBListNibViewController ()

@property (nonatomic, strong) WBTableViewAdapter *adapter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WBListNibViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Nib List";
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.adapter = [[WBTableViewAdapter alloc] init];
    self.tableView.adapter = self.adapter;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData{
    
    [self.adapter addSection:^(WBTableSection * _Nonnull section) {
        
        for (NSInteger index = 0; index < 5; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            row.calculateHeight = ^CGFloat(WBTableRow *row){
                return 60.0f;
            };
            row.associatedCellClass = [WBListNibCell class];
            [section addRow:row];
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    });
}


@end
