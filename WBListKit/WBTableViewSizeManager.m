//
//  WBTableViewSizeManager.m
//  WBListKit
//
//  Created by fangyuxi on 2019/2/25.
//

#import "WBTableViewSizeManager.h"

static WBTableViewSizeManager *instance = nil;

@implementation WBTableViewSizeManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
