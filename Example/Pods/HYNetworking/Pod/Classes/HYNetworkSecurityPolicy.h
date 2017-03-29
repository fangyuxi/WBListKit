//
//  HYNetworkSecurityPolicy.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/9.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HYNetworkDefines.h"

@interface HYNetworkSecurityPolicy : NSObject
{
    
}

//证书的校验模式 默认 HYSSLPinningModeCertificate
@property (nonatomic, assign)HYSSLPinningMode pinningMode;
//是否使用未受信任的证书 默认NO
@property (nonatomic, assign) BOOL allowInvalidCertificates;
//是否校验CN字段的domain 默认YES
@property (nonatomic, assign) BOOL validatesDomainName;


+ (instancetype)defaultSecurityPolicy;


@end
