//
//  WBSimpleListViewController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBSimpleListViewController.h"
#import "WBListKit.h"
#import "WBSimpleListCell.h"
#import "WBSimpleListAutoLayoutCell.h"

@interface WBSimpleListViewController ()<WBListActionToControllerProtocol>

@property (nonatomic, strong) WBTableViewAdapter *adapter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WBSimpleListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Simple List";
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.adapter = [[WBTableViewAdapter alloc] init];
    [self.tableView bindAdapter:self.adapter];
    self.tableView.actionDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData{
    
    [self.adapter beginAutoDiffer];
    
    [self.adapter addSection:^(WBTableSection * _Nonnull section) {
        
        for (NSInteger index = 0; index < 5; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            row.calculateHeight = ^CGFloat(WBTableRow *row){
                return 60.0f;
            };
            row.associatedCellClass = [WBSimpleListCell class];
            row.data = @{@"title":@(index)
                            };
            [section addRow:row];
        }
        section.identifier = @"FixedHeight";
    }];
    
    [self.adapter addSection:^(WBTableSection * _Nonnull section) {
        
        for (NSInteger index = 0; index < 5; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            row.associatedCellClass = [WBSimpleListAutoLayoutCell class];
            row.data = @{@"title":@(index)
                            };
            [section addRow:row];
        }
        section.identifier = @"AutoLayout";
    }];
    
    [self.adapter commitAutoDiffer];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WBTableSection *section = [self.adapter sectionAtIndex:indexPath.section];
    //[self.adapter beginAutoDiffer];
    [section deleteRowAtIndex:0];
    //[self.adapter commitAutoDiffer];
    
    //[tableView reloadData];
    //[self.adapter reloadDiffer];
    [self.adapter reloadSectionAtIndex:indexPath.section animation:UITableViewRowAnimationAutomatic usingBlock:^(WBTableSection * _Nonnull section) {
    }];
    //[self.adapter reloadDiffer];
}

- (void)actionFromReusableView:(UIView *)view
                      eventTag:(NSString *)tag
                     parameter:(id)param{
}


@end
