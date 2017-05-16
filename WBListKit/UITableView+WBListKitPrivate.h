//
//  UITableView+WBListKitPrivate.h
//  Pods
//
//  Created by Romeo on 2017/5/16.
//
//

#import <Foundation/Foundation.h>
#import "WBTableViewAdapter.h"

@interface UITableView (WBListKitPrivate)

@property (nonatomic, weak) WBTableViewAdapter *adapter;

@end
