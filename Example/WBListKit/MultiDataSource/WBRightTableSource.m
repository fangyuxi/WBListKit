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
    
    //刷新需要清空数据
    [self.tableViewAdapter beginAutoDiffer];
    [self.tableViewAdapter deleteAllSections];
    
    [self.tableViewAdapter addSection:^(WBTableSection * _Nonnull section) {
        
        section.key = @"fangyuxi";
        for (NSInteger index = 0; index < 5; ++index) {
            WBTableRow *row = [[WBTableRow alloc] init];
            row.associatedCellClass = [WBSimpleListAutoLayoutCell class];
            row.data = @{@"title":@(index)
                         };
            [section addRow:row];
        }
    }];
    
    self.canLoadMore = YES;
    [self notifyDidFinishLoad];
    [self.tableViewAdapter commitAutoDifferWithAnimation:YES];
}

@end
