//
//  WBListSectionHeaderFooter.m
//  Pods
//
//  Created by fangyuxi on 2017/3/20.
//
//

#import "WBTableSectionHeaderFooter.h"

const CGFloat WBTableHeaderFooterHeightAutoLayout = -1.0f;

@implementation WBTableSectionHeaderFooter

- (void)updateHeight
{
    if (self.height == WBTableHeaderFooterHeightAutoLayout) {
        return;
    }
    
    if (self.calculateHeight) {
        self.calculateHeight(self);
    }
}


@end
