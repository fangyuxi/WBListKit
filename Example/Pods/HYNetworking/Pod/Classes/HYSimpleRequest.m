//
//  HYGeneralRequest.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/9.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYSimpleRequest.h"

@implementation HYSimpleRequest

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _simpleRequestMethod = HYRequestMethodGet;
        self.validator = nil;
        return self;
    }
    return nil;
}

- (HYRequestMethod)requestMethod{
    return _simpleRequestMethod;
}

- (NSString *)api{
    return _api;
}

- (NSString *)identifier{
    return _identifier;
}

- (NSDictionary *)requestHeaderDictionary{
    return _header;
}

- (NSTimeInterval)requestTimeout{
    return _timeout;
}

- (HYConstructingBlock)constructedBodyBlock{
    return _bodyBlock;
}

- (NSDictionary *)requestArgument{
    return _arguments;
}

- (NSString *)downloadPath{
    return _downloadPath;
}

@end
