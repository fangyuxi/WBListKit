//
//  HYNetworkResponse.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkResponse.h"
#import "HYNetworking.h"
#import <CommonCrypto/CommonDigest.h>

static NSString *const HYResponseStatusKey            = @"HYResponseStatusKey";
static NSString *const HYResponseHTTPHeadFieldsKey    = @"HYResponseHTTPHeadFieldsKey";
static NSString *const HYResponseHTTPStatusCodeKey    = @"HYResponseHTTPStatusCodeKey";
static NSString *const HYResponseContentKey           = @"HYResponseContentKey";
static NSString *const HYResponseRequestURLKey        = @"HYResponseRequestURLKey";
static NSString *const HYResponseRequestIdentifierKey = @"HYResponseRequestIdentifierKey";
static NSString *const HYResponseErrorKey             = @"HYResponseErrorKey";
static NSString *const HYResponseErrorMSGKey          = @"HYResponseErrorMSGKey";
static NSString *const HYResponseHYRequestKey         = @"HYResponseHYRequestKey";

@interface HYNetworkResponse ()
{
    
}

//状态
@property (nonatomic, assign, readwrite)HYResponseStatus status;

//返回值
@property (nonatomic, strong, readwrite)NSDictionary *responseHTTPHeadFields;
@property (nonatomic, assign, readwrite)NSInteger responseHTTPStatusCode;
@property (nonatomic, strong, readwrite)id content;

//请求的相关属性
@property (nonatomic, copy, readwrite)NSString *requestURL;
@property (nonatomic, copy, readwrite)NSString *requestIdentifier;
@property (nonatomic, strong, readwrite)NSError *error;
@property (nonatomic, copy, readwrite)NSString *errorMSG;

@end

@implementation HYNetworkResponse

- (void)dealloc
{
    
}

- (instancetype) init
{
    NSLog(@"Use \"initWithResponse to create");
    return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        NSString *identifier = [aDecoder decodeObjectForKey:HYResponseRequestIdentifierKey];
        _requestIdentifier = identifier ? identifier : @"";
        
        NSString *url = [aDecoder decodeObjectForKey:HYResponseRequestURLKey];
        _requestURL = url ? url : @"";
        _content = [aDecoder decodeObjectForKey:HYResponseContentKey];
        _responseHTTPHeadFields = [aDecoder decodeObjectForKey:HYResponseHTTPHeadFieldsKey];
        _responseHTTPStatusCode = [[aDecoder decodeObjectForKey:HYResponseHTTPStatusCodeKey] integerValue];
        _status = [[aDecoder decodeObjectForKey:HYResponseStatusKey] integerValue];
        _fromCache = YES;
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.requestIdentifier forKey:HYResponseRequestIdentifierKey];
    self.requestURL ? [aCoder encodeObject:self.requestURL forKey:HYResponseRequestURLKey] :nil;
    self.content ? [aCoder encodeObject:self.content forKey:HYResponseContentKey] :nil;
    self.responseHTTPHeadFields ? [aCoder encodeObject:self.responseHTTPHeadFields
                                                forKey:HYResponseHTTPHeadFieldsKey] :nil;
    [aCoder encodeObject:@(self.responseHTTPStatusCode) forKey:HYResponseHTTPStatusCodeKey];
    [aCoder encodeObject:@(self.status) forKey:HYResponseStatusKey];
}

- (instancetype)initWithResponse:(NSHTTPURLResponse *)systemResponse
                       hyRequest:(HYBaseRequest *)hyRequest
                    responseData:(id)content
                          status:(HYResponseStatus)status
                           error:(NSError *)error
{
    self = [super init];
    if (self)
    {
        _status = status;
        _fromCache = NO;
        
        _requestIdentifier = [[hyRequest identifier] copy];
        _requestURL = [[hyRequest URL] copy];
        _content = content;
        
        _responseHTTPHeadFields = [systemResponse allHeaderFields];
        _responseHTTPStatusCode = [systemResponse statusCode];
        
        self.error = error;
        _hyRequest = hyRequest;
        
        return self;
    }
    return nil;
}

#pragma mark error setter format error&msg

- (void)setError:(NSError *)error
{
    _error = error;
    //网络错误
    if (error.code == NSURLErrorNotConnectedToInternet ||
        error.code == NSURLErrorCannotConnectToHost ||
        error.code == NSURLErrorNetworkConnectionLost ||
        error.code == NSURLErrorTimedOut ||
        error.code == NSURLErrorCannotFindHost)
    {
        self.status = HYResponseStatusConnectionFailed;
        self.errorMSG = KNetworkConnectErrorMSG;
    }
    else if (error.code == NSURLErrorCancelled)
    {
        self.status = HYResponseStatusCanceled;
        self.errorMSG = KNetworkConnectCancelErrorMSG;
    }
    else if (error)
    {
        //参数验证错误
        if (self.status == HYResponseStatusValidatorFailed)
        {
            self.errorMSG = KNetworkResponseValidatetErrorMSG;
        }
        //其他错误
        else
        {
            self.errorMSG = error.localizedDescription;
        }
    }
}



@end








