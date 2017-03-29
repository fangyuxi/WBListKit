//
//  HYNetworkDefines.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

NSString *const KNetworkConnectErrorMSG = @"网络错误，请检查网络";
NSString *const KNetworkConnectCancelErrorMSG = @"请求被取消";
NSString *const KNetworkResponseValidatetErrorMSG = @"参数验证错误";
NSString *const KNetworkHYErrorDomain = @"HYNetworkErrorDomain";
NSString *const KNetworkHYBusinessCore = @"core";

NSInteger const KNetworkResponseValidatetErrorCode = -1;

NSString * URLParametersStringFromParameters(NSDictionary *parameters)
{
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    if (parameters && parameters.count > 0)
    {
        for (NSString *key in parameters)
        {
            NSString *value = parameters[key];
            value = [NSString stringWithFormat:@"%@",value];
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}

NSString * URLStringWithOriginUrlString(NSString *originUrlString, NSDictionary *parameters)
{
    NSString *filteredUrl = originUrlString;
    NSString *paraUrlString = URLParametersStringFromParameters(parameters);
    if (paraUrlString && paraUrlString.length > 0)
    {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound)
        {
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        }
        else
        {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;
    }
    else
    {
        return originUrlString;
    }
}

NSString *HYSStringMD5(NSString *string) {
    if (!string) return nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],  result[3],
            result[4],  result[5],  result[6],  result[7],
            result[8],  result[9],  result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

NSString *SanitizeFileNameString(NSString *fileName)
{
    NSCharacterSet* illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>:=&."];
    return [[fileName componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@""];
}
