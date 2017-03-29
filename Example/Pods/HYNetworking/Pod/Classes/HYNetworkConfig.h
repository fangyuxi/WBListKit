//
//  HYNetworkConfig.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYNetworkParameterDecoratorProtocol.h"
#import "HYNetworkSecurityPolicy.h"
#import "HYNetworkServer.h"
#import "HYResponseCache.h"

@interface HYNetworkConfig : NSObject
{
    
}

+ (HYNetworkConfig *)sharedInstance; 

/**
 default server
 */
@property (nonatomic, strong) id<HYNetworkServerProtocol> defaultSever;


/**
 compose decorator chain
 */
@property (nonatomic, strong, readonly) NSArray<id<HYNetworkParameterDecoratorProtocol>> *urlDecorators;

@property (nonatomic, strong) HYNetworkSecurityPolicy *securityPolicy;

/**
 cache control
 */
@property (nonatomic, strong) HYResponseCache *cache;

- (void)addUrlDecorator:(id<HYNetworkParameterDecoratorProtocol>)decorator;

/**
 log switch
 */
@property (nonatomic, assign, getter=isRequestLogOn) BOOL logRequest;
@property (nonatomic, assign, getter=isResponseLogOn) BOOL logResponse;
@property (nonatomic, assign, getter=isHeaderLogOn) BOOL logHeader;

@end
