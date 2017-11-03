//
//  WBListRefreshControlProtocol.h
//  Pods
//
//  Created by fangyuxi on 2017/6/6.
//
//

#ifndef WBListRefreshControlProtocol_h
#define WBListRefreshControlProtocol_h


#import "WBListRefreshControlCallbackProtocol.h"

@protocol WBListRefreshControlProtocol <NSObject>

/**
 将控件关联到 UIScrollView 并设置控件的事件回调

 @param scrollView 'UIScrollView'
 @param target '设置控件的事件回调'
 */
- (void)attachToView:(UIScrollView *)scrollView
    callbackTarget:(id<WBListRefreshControlCallbackProtocol>)target;

/**
 开始刷新
 */
- (void)begin;

/**
 结束刷新
 */
- (void)end;

/**
 有效
 */
- (void)enable;

/**
 无效，虽然设置了刷新控件，但是某一时刻需要禁止生效，比如在上拉刷新的时候禁止下拉刷新
 */
- (void)disable;

@end

#endif /* WBListRefreshControlProtocol_h */
