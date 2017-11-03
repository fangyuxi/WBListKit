//
//  WBExpandingCellReformer.m
//  WBListKit
//
//  Created by fangyuxi on 2017/5/24.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBExpandingCellReformer.h"

@interface WBExpandingCellReformer ()
@property (nonatomic, copy, readwrite) NSString *title;
@end

@implementation WBExpandingCellReformer

- (void)reformRawData:(id)data
               forRow:(WBTableRow *)row{
    self.title = @"未展开";
    self.isExpanding = NO;
}

- (void)setIsExpanding:(BOOL)isExpanding{
    _isExpanding = isExpanding;
    if (isExpanding) {
        self.title = @"展开了";
    }else{
        self.title = @"未展开";
    }
}

@end
