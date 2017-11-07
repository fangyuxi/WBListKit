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
    self.tableView.adapter = self.adapter;
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
            row.data = [@{@"title":@(index)
                            } mutableCopy];
            row.reloadKey = @"1";
            [section addRow:row];
        }
        section.key = @"FixedHeight";
    }];
    
//    [self.adapter addSection:^(WBTableSection * _Nonnull section) {
//        
//        for (NSInteger index = 0; index < 5; ++index) {
//            WBTableRow *row = [[WBTableRow alloc] init];
//            row.associatedCellClass = [WBSimpleListAutoLayoutCell class];
//            row.data = @{@"title":@(index)
//                            };
//            [section addRow:row];
//        }
//        section.key = @"AutoLayout";
//    }];
    
    [self.adapter commitAutoDifferWithAnimation:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WBTableSection *section = [self.adapter sectionAtIndex:indexPath.section];
    WBTableRow *row = [section rowAtIndex:0];
    
    NSMutableDictionary *data = row.data;
    [data setObject:@(indexPath.row + 100) forKey:@"title"];
    row.reloadKey = [NSString stringWithFormat:@"%@",@(indexPath.row + 100)];
    
    //[section deleteRowAtIndex:indexPath.row];
    //[self.adapter reloadDifferWithAnimation:YES];
    [self.adapter beginAutoDiffer];
//    row.data = @{@"title":@(indexPath.row + 100)
//                  };
//    WBTableRow *row2 = [section rowAtIndex:1];
//    row2.data = @{@"title":@(100)
//                 };
    //[section deleteRowAtIndex:indexPath.row];
    //[section exchangeRowAtIndex:1 withIndex:2];
    [self.adapter commitAutoDifferWithAnimation:NO];
}

- (void)actionFromReusableView:(UIView *)view
                      eventTag:(NSString *)tag
                     parameter:(id)param{
}


@end
