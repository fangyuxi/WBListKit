//
//  HYNetworkServer.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 servers must comform to protocol
 */
@protocol HYNetworkServerProtocol <NSObject>

/**
 identifier name of server
 */
@property (nonatomic, readonly, nonnull)NSString *serverName;

/**
 server's host
 */
@property (nonatomic, readonly, nonnull)NSString *host;


/**
 server environment switch
 */
@property (nonatomic, assign, getter=isOnline)BOOL online;

@optional
@property (nonatomic, assign, getter=isVerify)BOOL verify;

@end
