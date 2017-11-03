//
//  WBMVCRefreshFooter.m
//  WBListKit
//
//  Created by fangyuxi on 2017/6/6.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBMVCRefreshFooter.h"

@interface WBMVCRefreshFooter ()
@property (nonatomic, weak) UIScrollView *attchedView;
@end

@implementation WBMVCRefreshFooter

- (void)begin{
    [self beginRefreshing];
}

- (void)end{
    [self endRefreshing];
}

- (void)endWithNoMoreDataState{
    [self endRefreshingWithNoMoreData];
}

- (void)resetToNormalState{
    [self resetNoMoreData];
}

- (void)attachToView:(UIScrollView *)scrollView
      callbackTarget:(id<WBListRefreshControlCallbackProtocol>)target{
    
    self.attchedView = scrollView;
    scrollView.mj_footer = self;
    self.refreshingTarget = target;
    self.refreshingBlock = ^{
        [target refreshControlBeginLoadMore];
    };
}

- (void)enable{
    self.attchedView.mj_footer = self;
}

- (void)disable{
    self.attchedView.mj_footer = nil;
}


@end
