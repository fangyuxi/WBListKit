//
//  HYBaseRequestHiddenInterface.h
//  Pods
//
//  Created by fangyuxi on 16/4/28.
//
//

#ifndef HYBaseRequestHiddenInterface_h
#define HYBaseRequestHiddenInterface_h

#import "HYBaseRequest.h"

@interface HYBaseRequest ()

@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, copy, readwrite)NSString *URL;
@property (nonatomic, strong) NSDictionary *allParam;
@property (nonnull, copy) NSString *key;

- (void)clearBlock;

@end

#endif /* HYBaseRequestHiddenInterface_h */
