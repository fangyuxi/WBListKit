//
//  UIViewController+WBList.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/23.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "UIViewController+WBList.h"
#import <objc/runtime.h>

static int ListControllerKey;

@implementation UIViewController (WBList)

#pragma mark ListController

- (WBListController *)list{
    WBListController *list = objc_getAssociatedObject(self, &ListControllerKey);
    if (!list) {
        list = [[WBListController alloc] initWithController:self];
        objc_setAssociatedObject(self, &ListControllerKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return list;
}

@end
