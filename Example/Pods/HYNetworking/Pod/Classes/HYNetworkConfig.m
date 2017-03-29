//
//  HYNetworkConfig.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkConfig.h"

@implementation HYNetworkConfig{

    NSMutableArray *_urlFilters;
}

@synthesize urlDecorators = _urlFilters;

#pragma mark init

+ (HYNetworkConfig *)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.logRequest = YES;
        self.logResponse = YES;
        self.logHeader = YES;
        
        _urlFilters = [NSMutableArray array];
        
        //采用默认的安全策略
        _securityPolicy = [HYNetworkSecurityPolicy defaultSecurityPolicy];
    }
    return self;
}

#pragma mark filters

- (void)addUrlDecorator:(id<HYNetworkParameterDecoratorProtocol>)decorator
{
    if (!decorator){
        return;
    }
    [_urlFilters addObject:decorator];
}



@end
