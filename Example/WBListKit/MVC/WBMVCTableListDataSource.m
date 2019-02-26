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
@import WBListKit;

@implementation WBMVCTableListDataSource

- (void)loadSource{
    
    [self notifyWillLoad];
    
    //此处可以是网络层代码,也可是本地数据
    
    //刷新需要清空数据
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableViewAdapter beginAutoDiffer];
            [self.tableViewAdapter deleteAllSections];
            [self.tableViewAdapter addSection:^(WBTableSection * _Nonnull section) {
                
                [section setKey:@"fangyuxi"];
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
                    [section addRow:row];
                }
            }];
            [self.tableViewAdapter commitAutoDifferWithAnimation:YES];
            
            self.canLoadMore = YES;
            [self notifyDidFinishLoad];
        });
    });
}

- (void)loadMoreSource{
    
    [self notifyWillLoadMore];
    
    //此处可以是网络层代码,也可是本地数据
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //追加数据 所以是update
            [self.tableViewAdapter beginAutoDiffer];
            [self.tableViewAdapter updateSectionForKey:@"fangyuxi" useBlock:^(WBTableSection * _Nonnull section) {
                
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
                    [section addRow:row];
                }
                if (section.rowCount > 100) {
                    self.canLoadMore = NO;
                }else{
                    self.canLoadMore = YES;
                }
            }];
            [self.tableViewAdapter commitAutoDifferWithAnimation:YES];
            
            [self notifyDidFinishLoadMore];
        });
    });
}

@end
