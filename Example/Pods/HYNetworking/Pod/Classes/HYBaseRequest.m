//
//  HYBaseRequest.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseRequest.h"
#import "HYBaseRequestPrivate.h"
#import "HYBaseRequestInternal.h"
#import <objc/runtime.h>

@interface HYBaseRequest ()

@end

@implementation HYBaseRequest

#pragma mark init

- (instancetype)init
{
    self = [super init];
    if (self){
        self.validator = (id <HYRequestValidator>)self;
        return self;
    }
    return nil;
}

#pragma mark request action

//发起请求
- (void)start{
    [[HYBaseRequestInternal sharedInstance] sendRequest:self];
    return;
}

- (void)startWithSuccessHandler:(HYRequestFinishedSuccessHandler)successHandler
                 failuerHandler:(HYRequestFinishedFailuerHandler)failerHandler{
    self.successHandler = successHandler;
    self.failerHandler = failerHandler;
    [self start];
}

//取消请求
- (void)cancel{
    [[HYBaseRequestInternal sharedInstance] cancelRequeset:self];
    return;
}

- (BOOL)isLoading{
    return [[HYBaseRequestInternal sharedInstance] isLoadingRequest:self];
}

//打破循环引用
- (void)clearBlock{
    self.successHandler = nil;
    self.failerHandler = nil;
    self.progressHandler = nil;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"url:%@ identifier : %@", [self apiUrl],[self name]];
}

#pragma mark protocol empty method must complete in child

- (HYRequestMethod)requestMethod{
    [self doesNotRecognizeSelector:_cmd];
    return HYRequestMethodGet ;
}

- (NSString *)apiUrl{
    [self doesNotRecognizeSelector:_cmd];
    return nil ;
}

- (NSString *)name{
    [self doesNotRecognizeSelector:_cmd];
    return nil ;
}

- (NSDictionary *)requestHeaderValueDictionary{
    return nil;
}

- (NSTimeInterval)requestTimeoutInterval{
    return 0;
}

- (HYConstructingBlock)constructingBodyBlock{
    return nil;
}

- (NSDictionary *)requestArgument{
    return nil;
}

- (NSString *)downloadPath{
    return nil;
}

/**
 *  CacheMaxAge default 3 days
 *
 *  @return NStimeInterval by second
 */
- (NSTimeInterval)cacheMaxAge
{
    return KHYResponseCacheMaxAge;
}

/**
 *  How to cache data
 *
 *  @return Enum HYRequestCachePolicy
 */
- (HYRequestCachePolicy)cachePolicy
{
    return HYRequestCachePolicyNeverUseCache;
}


@end
