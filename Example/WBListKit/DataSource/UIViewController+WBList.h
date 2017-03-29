//
//  UIViewController+WBList.h
//  WBListKit
//
//  Created by fangyuxi on 2017/3/23.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBListDataSource.h"
#import "WBListDataSourceDelegate.h"
#import "WBListController.h"
#import "MJRefresh.h"

@interface UIViewController(WBList)<WBListDataSourceDelegate>

/**
 相当于为控制器创建了一个list的命名空间
 */
@property (nonatomic, strong, nullable, readonly) WBListController *list;

@end
