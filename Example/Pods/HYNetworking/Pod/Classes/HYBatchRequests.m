//
//  HYBatchRequests.m
//  Pods
//
//  Created by fangyuxi on 16/7/27.
//
//

#import "HYBatchRequests.h"
#import "HYBaseRequestInternal.h"

@interface HYBatchRequests ()

@property (nonatomic, strong, readwrite) NSMutableSet *requests;

@end

@implementation HYBatchRequests

- (instancetype)init
{
    self = super.init;
    _requests = [NSMutableSet new];
    return self;
}

- (void)addRequest:(HYBaseRequest *)request
{
    NSParameterAssert(request);
    NSAssert([request isKindOfClass:[HYBaseRequest class]],
             @"");
    if ([self.requests containsObject:request]) {
#ifdef DEBUG
        NSLog(@"Add SAME API into BatchRequest set");
#endif
    }
    
    [self.requests addObject:request];
}


- (void)start
{
#ifdef DEBUG
    NSAssert([self.requests count] != 0, @"Batch API Amount can't be 0");
#endif
    
    [[HYBaseRequestInternal sharedInstance] sendBatchRequest:self];
}

- (void)cancel
{
    [self.requests enumerateObjectsUsingBlock:^(id  obj, BOOL * stop) {
        
        HYBaseRequest *request = obj;
        [request cancel];
    }];
}

@end
