//
//  HYNetworkLogger.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkLogger.h"
#import "HYNetworkResponse.h"
#import "HYNetworkServer.h"
#import "HYBaseRequest.h"
#import "HYNetworkConfig.h"
#import "HYBaseRequestPrivate.h"

@implementation HYNetworkLogger


+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static HYNetworkLogger *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)logResponse:(HYNetworkResponse *)response
        withRequest:(HYBaseRequest *)request
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        BOOL needLog = request.debugMode ? YES : [HYNetworkConfig sharedInstance].logResponse;
        
        if (!needLog)
        {
            return;
        }
        
        //头
        NSMutableString *log = [NSMutableString stringWithFormat:@"\n==================================================================================\n               Response  status:%@  code:%ld           \n==================================================================================\n\n",[self statusStringOfCode:response.status], (long)response.responseHTTPStatusCode];
        
        //返回的内容
        if ([HYNetworkConfig sharedInstance].logHeader)
        {
            [log appendString:@"Response Header \n"];
            [log appendString:[self jsonStringWithObject:response.responseHTTPHeadFields]];
            [log appendString:@"\n\n"];
        }
        
        [log appendString:@"Response Content \n"];
        [log appendString:[self jsonStringWithObject:response.content]];
        [log appendString:@"\n"];
        
        //error
        if (response.error)
        {
            [log appendString:@"\n"];
            [log appendString:response.errorMSG ? response.errorMSG : @""];
            [log appendString:@"\n"];
            [log appendFormat:@"Error Domain:\t\t\t\t%@\n", response.error.domain];
            [log appendFormat:@"Error Domain Code:\t\t\t%ld\n", (long)response.error.code];
            [log appendFormat:@"Error Description:\t\t\t%@\n", response.error.localizedDescription];
            [log appendFormat:@"Error Failure Reason:\t\t%@\n", response.error.localizedFailureReason];
            [log appendFormat:@"Error Recovery Suggestion:\t%@\n", response.error.localizedRecoverySuggestion];
        }
        
        //这个response对应的request信息
        [log appendString:@"\n---------------  Related Request Start  --------------\n\n"];
        if ([HYNetworkConfig sharedInstance].logHeader)
        {
            [log appendString:@"Request Header \n"];
            [log appendString:[self jsonStringWithObject:response.responseHTTPHeadFields]];
            [log appendString:@"\n\n"];
        }
        
        //request的参数
        [log appendString:@"Request param \n"];
        [log appendString:[self jsonStringWithObject:[request allParam]]];
        [log appendString:@"\n\n"];
        [log appendString:@"Request URL \n"];
        [log appendString:response.requestURL ? response.requestURL : @"url丢失"];
        [log appendString:@"\n\n---------------  Related Request End  --------------\n"];
        
        [log appendString:@"\n==================================================================================\n                            Response End           \n==================================================================================\n\n"];
        NSLog(@"%@",log);
    });
}

- (NSString *)jsonStringWithObject:(id)object
{
    if (object)
    {
        NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string ?string : @"数据有问题";
    }
    return @"none";
}

- (void)logRequest:(HYBaseRequest *)request
     systemRequest:(NSURLRequest *)systemRequest
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        BOOL needLog = request.debugMode ? YES : [HYNetworkConfig sharedInstance].logRequest;
        
        if (!needLog)
        {
            return;
        }
        
        //头
        NSMutableString *log = [NSMutableString stringWithFormat:@"\n==================================================================================\n                      Request Start            \n==================================================================================\n\n"];
        
        //request信息
        if ([HYNetworkConfig sharedInstance].logHeader)
        {
            [log appendString:@"Request Header \n"];
            [log appendString:[self jsonStringWithObject:systemRequest.allHTTPHeaderFields]];
            [log appendString:@"\n\n"];
        }
        
        //request的参数
        [log appendString:@"Request param \n"];
        [log appendString:[self jsonStringWithObject:[request allParam]]];
        [log appendString:@"\n\n"];
        [log appendString:@"Request URL \n"];
        [log appendString:request.URL ? request.URL : @"url丢失"];
        [log appendString:@"\n"];
        
        [log appendString:@"\n==================================================================================\n                        Reqeust End           \n==================================================================================\n\n"];
        
        NSLog(@"%@",log);
    });
}

- (NSString *)statusStringOfCode:(NSInteger)code
{
    switch (code) {
        case HYResponseStatusDefault:
            return @"HYResponseStatusDefault";
            break;
        case HYResponseStatusSuccess:
            return @"HYResponseStatusSuccess";
            break;
        case HYResponseStatusSuccessWithoutValidator:
            return @"HYResponseStatusSuccessWithoutValidator";
            break;
        case HYResponseStatusConnectionFailed:
            return @"HYResponseStatusConnectionFailed";
            break;
        case HYResponseStatusCanceled:
            return @"HYResponseStatusCanceled";
            break;
        case HYResponseStatusFailed:
            return @"HYResponseStatusFailed";
            break;
        case HYResponseStatusValidatorFailed:
            return @"HYResponseStatusValidatorFailed";
            break;
            
        default:
            break;
    }
    return @"Unkown";
}

@end
