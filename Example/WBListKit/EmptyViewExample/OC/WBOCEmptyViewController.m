//
//  WBOCEmptyViewController.m
//  WBListKit
//
//  Created by Romeo on 2017/5/12.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBOCEmptyViewController.h"
#import "WBSimpleListCell.h"
#import "WBSimpleListAutoLayoutCell.h"
#import "OCAndSwift-Swift.h"

@interface WBOCEmptyViewController ()<WBListActionToControllerProtocol>

@property (nonatomic, strong) WBTableViewAdapter *adapter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WBOCEmptyViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Simple List";
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.adapter = [[WBTableViewAdapter alloc] init];
    self.adapter.actionDelegate = self;
    [self.adapter bindTableView:self.tableView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData{
    
//    [self.adapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
//        
//        for (NSInteger index = 0; index < 5; ++index) {
//            WBTableRow *row = [[WBTableRow alloc] init];
//            row.calculateHeight = ^CGFloat(WBTableRow *row){
//                return 60.0f;
//            };
//            row.associatedCellClass = [WBSimpleListCell class];
//            row.data = @{@"title":@(index)
//                         };
//            maker.addRow(row).setIdentifier(@"FixedHeight");
//        }
//    }];
//    
//    [self.adapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
//        
//        for (NSInteger index = 0; index < 5; ++index) {
//            WBTableRow *row = [[WBTableRow alloc] init];
//            row.associatedCellClass = [WBSimpleListAutoLayoutCell class];
//            row.data = @{@"title":@(index)
//                         };
//            maker.addRow(row).setIdentifier(@"AutoLayout");
//        }
//    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.tableView reloadEmptyView];
        });
    });
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)actionFromReusableView:(UIView *)view
                  withEventTag:(NSString *)tag
           withParameterObject:(id)object{
}


@end
