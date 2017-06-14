//
//  WBListHeaderFooterViewController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBListHeaderFooterViewController.h"
#import "WBListKit.h"
#import "WBHeaderFooterCell.h"
#import "WBDemoHeaderView.h"
#import "WBDemoFooterView.h"

@interface WBListHeaderFooterViewController ()

@property (nonatomic, strong) WBTableViewAdapter *adapter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WBListHeaderFooterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.adapter = [[WBTableViewAdapter alloc] init];
    [self.tableView bindAdapter:self.adapter];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData{
    
    [self.adapter addSection:^(WBTableSection * _Nonnull section) {
        
        WBTableRow *row = [[WBTableRow alloc] init];
        row.calculateHeight = ^CGFloat(WBTableRow *row) {
            return 100.0f;
        };
        row.position = WBTableRowPositionSingle;
        row.associatedCellClass = [WBHeaderFooterCell class];
        
        WBTableSectionHeaderFooter *header = [WBTableSectionHeaderFooter new];
        header.displayType = WBTableHeaderFooterTypeHeader;
        header.associatedHeaderFooterClass = [WBDemoHeaderView class];
        
        WBTableSectionHeaderFooter *footer = [WBTableSectionHeaderFooter new];
        footer.calculateHeight = ^CGFloat(WBTableSectionHeaderFooter *headerFooter) {
          
            return 80.0f;
        };
        footer.displayType = WBTableHeaderFooterTypeFooter;
        footer.associatedHeaderFooterClass = [WBDemoFooterView class];
        
        [section addRow:row];
        section.header = header;
        section.footer = footer;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    });
}

@end
