//
//  WBMVCRefreshHeader.m
//  WBListKit
//
//  Created by fangyuxi on 2017/6/6.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBMVCRefreshHeader.h"

@interface WBMVCRefreshHeader ()
@property (nonatomic, weak) UIScrollView *attchedView;
@end

@implementation WBMVCRefreshHeader

- (void)begin{
    [self beginRefreshing];
}

- (void)end{
    [self endRefreshing];
}

- (void)attachToView:(UIScrollView *)scrollView
      callbackTarget:(id<WBListRefreshControlCallbackProtocol>)target{
    
    self.attchedView = scrollView;
    scrollView.mj_header = self;
    self.refreshingTarget = target;
    self.refreshingBlock = ^{
        [target refreshControlBeginRefreshing];
    };
}

- (void)enable{
    self.attchedView.mj_header = self;
}

- (void)disable{
    self.attchedView.mj_header = nil;
}

@end
