//
//  UITableView+WBListKitPrivate.h
//  Pods
//
//  Created by fangyuxi on 2017/5/16.
//
//

#import <Foundation/Foundation.h>
#import "WBTableViewAdapter.h"

/**
 隐藏这个属性，防止外部访问到
 */
@class WBTableViewDataSource;
@class WBTableViewAdapter;

@interface UITableView (WBListKitPrivate)

@property (nonatomic, weak) WBTableViewDataSource *source;

@end
