//
//  WBListRefreshControlCallbackProtocol.h
//  Pods
//
//  Created by Romeo on 2017/6/6.
//
//

#ifndef WBListRefreshControlCallbackProtocol_h
#define WBListRefreshControlCallbackProtocol_h

@protocol WBListRefreshControlCallbackProtocol <NSObject>

- (void)refreshControlBeginRefreshing;
- (void)refreshControlBeginLoadMore;

@end

#endif /* WBListRefreshControlCallbackProtocol_h */
