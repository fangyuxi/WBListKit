//
//  WBListRefreshFooterViewProtocol.h
//  Pods
//
//  Created by Romeo on 2017/6/6.
//
//

#ifndef WBListRefreshFooterViewProtocol_h
#define WBListRefreshFooterViewProtocol_h

#import "WBListRefreshControlProtocol.h"

/**
 所有的刷新尾部控件都需要实现这个协议
 */
@protocol WBListRefreshFooterViewProtocol <WBListRefreshControlProtocol>

/**
 结束刷新，让控件置于没有数据的状态
 */
- (void)endWithNoMoreDataState;

/**
 结束没有数据的状态，恢复正常状态
 */
- (void)resetToNormalState;

@end

#endif /* WBListRefreshFooterViewProtocol_h */
