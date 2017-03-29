//
//  HYNetworkDefines.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/9.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark enum

//证书的验证模式
typedef NS_ENUM(NSUInteger, HYSSLPinningMode)
{
    
    //不校验证书
    HYSSLPinningModeNone,
    //只检验publicKey
    HYSSLPinningModePublicKey,
    //检验整个证书
    HYSSLPinningModeCertificate,
};

//请求方法
typedef NS_ENUM(NSInteger , HYRequestMethod)
{
    HYRequestMethodGet = 1,
    HYRequestMethodPost,
    HYRequestMethodHead,
    HYRequestMethodPut,
    HYRequestMethodDelete,
    HYRequestMethodPatch
};

//缓存方式
typedef NS_ENUM(NSInteger , HYRequestCachePolicy)
{
    //不写缓存
    HYRequestCachePolicyNeverUseCache = 1,
    //不读缓存，但是写缓存
    HYRequestCachePolicyDonotReadCache,
    //先读缓存再请求服务器
    HYRequestCachePolicyReadCacheAndRequest,
    //不管缓存是否有效，只读缓存
    HYRequestCachePolicyReadCache,
    //先读缓存，如果没有缓存，那么请求网络
    HYRequestCachePolicyReadCacheOrRequest,
    
};

#pragma mark timeout

#define KHYNetworkDefaultTimtout 20
#define KHYResponseCacheMaxAge 3 * 24 * 3600

#pragma mark error msg

extern NSString *const KNetworkConnectErrorMSG;
extern NSString *const KNetworkConnectCancelErrorMSG;
extern NSString *const KNetworkResponseValidatetErrorMSG;
extern NSInteger const KNetworkResponseValidatetErrorCode;
extern NSString *const KNetworkHYErrorDomain;

extern NSString *const KNetworkHYBusinessCore;

#pragma mark method

NSString *URLParametersStringFromParameters(NSDictionary *parameters);
NSString *URLStringWithOriginUrlString(NSString *originUrlString, NSDictionary *parameters);
NSString *HYSStringMD5(NSString *string);
NSString *SanitizeFileNameString(NSString *fileName);






