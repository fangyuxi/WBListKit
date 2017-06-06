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

@interface UIViewController(WBList)<WBListDataSourceDelegate>

/**
 相当于为控制器创建了一个list的命名空间，防止在加入现有项目中的时候命名冲突
 */
@property (nonatomic, strong, nullable, readonly) WBListController *list;

@end
