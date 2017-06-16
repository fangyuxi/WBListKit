//
//  WBExpandingCellViewController.m
//  WBListKit
//
//  Created by Romeo on 2017/5/24.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBExpandingCellViewController.h"
#import "WBExpandingCellReformer.h"
#import "WBExpandingCell.h"
#import "WBListKit.h"

@interface WBExpandingCellViewController ()<WBListActionToControllerProtocol>

@property (nonatomic, strong) WBTableViewAdapter *adapter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WBExpandingCellViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Expanding Cell List";
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.adapter = [[WBTableViewAdapter alloc] init];
    self.tableView.adapter = self.adapter;
    self.tableView.actionDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData{
    
    [self.adapter addSection:^(WBTableSection * _Nonnull section) {
        for (NSInteger index = 0; index < 5; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            WBExpandingCellReformer *reformer = [WBExpandingCellReformer new];
            [reformer reformRawData:nil forRow:row];
            row.data = reformer;
            row.associatedCellClass = [WBExpandingCell class];
            [section addRow:row];
            section.key = @"ExpandingCellSectionId";
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    });
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)actionFromReusableView:(UIView *)view
                      eventTag:(NSString *)tag
                     parameter:(id)param {
    WBTableRow *row = param;
    [self.adapter reloadRowAtIndex:row.indexPath
                         animation:UITableViewRowAnimationAutomatic
                        usingBlock:^(WBTableRow * _Nonnull row) {
                            WBExpandingCellReformer *reformer = row.data;
                            reformer.isExpanding = !reformer.isExpanding;
                        }];
}

@end
