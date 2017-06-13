//
//  WBMVCListDataSource.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/24.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBMVCTableListDataSource.h"
#import "WBReformerListCell.h"
#import "WBReformerListCellReformer.h"

@implementation WBMVCTableListDataSource

- (void)loadSource{
    
    [self notifyWillLoad];
    
    //此处可以是网络层代码,也可是本地数据
    
    //刷新需要清空数据
    [self.tableViewAdapter deleteAllSections];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableViewAdapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
                
                maker.setIdentifier(@"fangyuxi");
                //maker.animationUpdate = YES;
                for (NSInteger index = 0; index < 15; ++index) {
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
            
            self.canLoadMore = YES;
            [self notifyDidFinishLoad];
        });
    });
}

- (void)loadMoreSource{
    
    [self notifyWillLoadMore];
    
    //此处可以是网络层代码,也可是本地数据
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //追加数据 所以是update
            [self.tableViewAdapter updateSectionForIdentifier:@"fangyuxi" useMaker:^(WBTableSectionMaker * _Nonnull maker) {
                
                //maker.animationUpdate = YES;
                for (NSInteger index = 0; index < 15; ++index) {
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
                if (maker.rowCount > 30) {
                    self.canLoadMore = NO;
                }else{
                    self.canLoadMore = YES;
                }
            }];
            
            [self notifyDidFinishLoadMore];
        });
    });
}

@end
