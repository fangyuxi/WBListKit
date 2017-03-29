//
//  HYGeneralRequest.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/9.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseRequest.h"

/**
 *  对于简单的请求，使用这个Reqeust，通过Block回调
    对于复杂的请求，请继承HYBaseRequest，通过Delegate
    的方式回调
 */

@class HYSimpleRequest;

@interface HYSimpleRequest : HYBaseRequest

/**
 *  以下属性对应的是HYBaseRequestProtocol中的方法
 */
@property (nonatomic, assign) HYRequestMethod simpleRequestMethod;
@property (nonatomic, copy, nonnull) NSString *api;
@property (nonatomic, copy, nonnull) NSString *identifier;
@property (nonatomic, strong, nullable) NSDictionary *arguments;
@property (nonatomic, strong, nullable) NSDictionary *header;
@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, copy, nullable) NSString *downloadPath;
@property (nonatomic, copy, nullable) HYConstructingBlock bodyBlock;

@end
