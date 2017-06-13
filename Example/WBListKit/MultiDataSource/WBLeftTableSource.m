//
//  WBLeftTableSource.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/29.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBLeftTableSource.h"
#import "WBReformerListCell.h"
#import "WBReformerListCellReformer.h"

@implementation WBLeftTableSource

- (void)loadSource{
    
    [self notifyWillLoad];
    
    //此处可以是网络层代码,也可是本地数据
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //刷新需要清空数据
            [self.tableViewAdapter beginAutoDiffer];
            [self.tableViewAdapter deleteAllSections];
            
            [self.tableViewAdapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
                
                maker.setIdentifier(@"fangyuxi");
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
            
            self.canLoadMore = NO;
            [self notifyDidFinishLoad];
            [self.tableViewAdapter commitAutoDiffer];
        });
    });
}



@end
