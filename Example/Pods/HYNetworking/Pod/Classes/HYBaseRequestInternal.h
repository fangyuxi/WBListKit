//
//  HYBaseRequestInternal.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBaseRequest.h"
#import "HYBaseRequestPrivate.h"
#import "HYNetworkConfig.h"
#import "HYBatchRequests.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseRequestInternal : NSObject
{

}

+ (HYBaseRequestInternal *)sharedInstance;


/**
 send request

 @param request 'request'
 @param completeGroup 'callback in completeGroup'
 */
- (void)sendRequest:(HYBaseRequest *)request
  withCompleteGroup:(nullable dispatch_group_t)completeGroup;

/**
 send request in default completeGroup

 @param request 'request'
 */
- (void)sendRequest:(HYBaseRequest *)request;

/**
 send batch requests

 @param requests array of request
 */
- (void)sendBatchRequest:(HYBatchRequests *)requests;

/**
 cancel
 */
- (void)cancelRequeset:(HYBaseRequest *)request;
- (void)cancelAllRequest;


- (BOOL)isLoadingRequest:(HYBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
