//
//  WBListTableViewDelegateProxy.h
//  Pods
//
//  Created by fangyuxi on 2017/3/20.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitMacros.h"

NS_ASSUME_NONNULL_BEGIN

WBListKit_SUBCLASSING_RESTRICTED
@interface WBTableViewDelegateProxy : NSProxy

- (instancetype)initWithTableDataSourceTarget:(id<UITableViewDataSource>)dataSource
                          tableDelegateTarget:(id<UITableViewDelegate>)delegate
                                  interceptor:(id)interceptor;

@end

NS_ASSUME_NONNULL_END
