//
//  HYNetworkLogger.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

//日志开关在HYNetworkConfig中

@class HYNetworkResponse;
@class HYBaseRequest;

@interface HYNetworkLogger : NSObject
{
    
}

+ (instancetype)sharedInstance;

//打印response
- (void)logResponse:(HYNetworkResponse *)response
        withRequest:(HYBaseRequest *)request;

//打印请求开始
- (void)logRequest:(HYBaseRequest *)request
     systemRequest:(NSURLRequest *)systemRequest;

@end
