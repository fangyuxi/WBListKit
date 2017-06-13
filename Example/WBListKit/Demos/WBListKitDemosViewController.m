//
//  WBListKitDemosViewController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/20.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBListKitDemosViewController.h"
#import "OCAndSwift-Swift.h"

#import "WBListKit.h"
#import "WBDemosCell.h"

#import "WBSimpleListViewController.h"
#import "WBReformerListViewController.h"
#import "WBListHeaderFooterViewController.h"
#import "WBMVCViewController.h"
#import "WBMultiSourceController.h"
#import "WBCollectionViewController.h"
#import "WBNestedViewController.h"
#import "WBCustomLayoutViewController.h"
#import "WBWaterFallViewController.h"
#import "WBOCEmptyViewController.h"
#import "WBExpandingCellViewController.h"
#import "WBListNibViewController.h"

@interface WBListKitDemosViewController ()<WBListActionToControllerProtocol>
@property (nonatomic, strong) WBTableViewAdapter *adapter;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation WBListKitDemosViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"WBListKit Demos";
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
    
    // hide warnings
    __weak typeof(self) weakSelf = self;
    [self.adapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
        
        NSMutableArray *rows = [NSMutableArray new];
        [[weakSelf data] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            WBTableRow *row = [[WBTableRow alloc] init];
            row.calculateHeight = ^CGFloat(WBTableRow *row){
                return 60.0f;
            };
            row.associatedCellClass = [WBDemosCell class];
            row.data = obj;
            [rows addObject:row];
            
        }];
        maker.addRows(rows).setIdentifier(@"DemoIdentifier");
    }];
    
    [self.adapter commitAutoDiffer];
}

- (NSArray *)data{
    return @[@{@"title":@"Simple List",@"class":[WBSimpleListViewController class]},
             @{@"title":@"Expanding Cell List",@"class":[WBExpandingCellViewController class]},
             @{@"title":@"Reformer List",@"class":[WBReformerListViewController class]},
             @{@"title":@"FooterHeader List",@"class":[WBListHeaderFooterViewController class]},
             @{@"title":@"MVC Demos",@"class":[WBMVCViewController class]},
             @{@"title":@"Multi DataSource",@"class":[WBMultiSourceController class]},
             @{@"title":@"CollectionView",@"class":[WBCollectionViewController class]},
             @{@"title":@"Nested",@"class":[WBNestedViewController class]},
             @{@"title":@"Nib Cell List",@"class":[WBListNibViewController class]},
             @{@"title":@"Custom Layout",@"class":[WBCustomLayoutViewController class]},
             @{@"title":@"WaterFall Layout",@"class":[WBWaterFallViewController class]},
             @{@"title":@"Empty Kit Swift ",@"class":[WBSwiftEmptyViewController class]},
             @{@"title":@"Empty Kit OC ",@"class":[WBOCEmptyViewController class]}
             ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBTableSectionMaker *maker = [self.adapter sectionAtIndex:indexPath.section];
    WBTableRow *row = maker.rowAtIndex(indexPath.row);
    UIViewController *controller = [[[row.data objectForKey:@"class"] alloc] init];
    controller.title = [row.data objectForKey:@"title"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
