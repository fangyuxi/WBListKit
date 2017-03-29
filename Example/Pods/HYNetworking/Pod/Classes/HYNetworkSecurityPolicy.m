//
//  HYNetworkSecurityPolicy.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/9.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkSecurityPolicy.h"

@implementation HYNetworkSecurityPolicy

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.allowInvalidCertificates = NO;
        self.validatesDomainName = YES;
        self.pinningMode = HYSSLPinningModeCertificate;
        return self;
    }
    return nil;
}

+ (instancetype)defaultSecurityPolicy
{
    return [[HYNetworkSecurityPolicy alloc] init];
}

@end
