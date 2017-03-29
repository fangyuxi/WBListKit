//
//  HYBatchRequests.h
//  Pods
//
//  Created by fangyuxi on 16/7/27.
//
//

#import <Foundation/Foundation.h>
#import "HYBaseRequest.h"



NS_ASSUME_NONNULL_BEGIN

/// 发送一系列请求 no-thread-safe

@class HYBatchRequests;

@protocol HYBatchRequestsDelegate <NSObject>

/**
 *  @brief 所有请求完成之后回调
 *
 *  @param batchApis
 */
- (void)batchAPIRequestsDidFinished:(HYBatchRequests *)batchApis;

@end

@interface HYBatchRequests : NSObject

@property (nullable, nonatomic, weak) id<HYBatchRequestsDelegate> delegate;
@property (nonatomic, strong, readonly) NSMutableSet *requests;

- (void)addRequest:(nonnull HYBaseRequest *)request;

- (void)start;
- (void)cancel;

@end

NS_ASSUME_NONNULL_END