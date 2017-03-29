//
//  HYNetworkUrlFilterProtocol.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//


@class HYNetworkResponse;
@class HYBaseRequest;

@protocol HYNetworkParameterDecoratorProtocol <NSObject>

@required

- (NSString *)businessId;

// in
@property (nonatomic, copy)NSString *inUrl;
@property (nonatomic, strong)NSDictionary *inParameterDic;
@property (nonatomic, strong)HYBaseRequest *inRequest;

// out
@property (nonatomic, copy, readonly)NSString *outUrl;
@property (nonatomic, strong, readonly)NSDictionary *outParameterDic;

@end

