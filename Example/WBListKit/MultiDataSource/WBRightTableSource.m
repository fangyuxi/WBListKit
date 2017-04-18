//
//  WBRightTableSource.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/29.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBRightTableSource.h"
#import "WBSimpleListAutoLayoutCell.h"

@implementation WBRightTableSource

- (void)loadSource{
    
    [self notifyWillLoad];
    
    //此处可以是网络层代码,也可是本地数据
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //刷新需要清空数据
            [self.tableViewAdapter deleteAllSections];
            
            [self.tableViewAdapter addSection:^(WBTableSectionMaker * _Nonnull maker) {
                
                maker.setIdentifier(@"fangyuxi");
                for (NSInteger index = 0; index < 5; ++index) {
                    WBTableRow *row = [[WBTableRow alloc] init];
                    row.associatedCellClass = [WBSimpleListAutoLayoutCell class];
                    row.data = @{@"title":@(index)
                                 };
                    maker.addRow(row);
                }
            }];
            
            self.canLoadMore = YES;
            [self notifyDidFinishLoad];
        });
    });
}

@end
