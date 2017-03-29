//
//  WBListTableViewDelegateProxy.m
//  Pods
//
//  Created by fangyuxi on 2017/3/20.
//
//

#import "WBTableViewDelegateProxy.h"
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"

/**
 Define messages that you want the adapter object to intercept. Pattern copied from
 https://github.com/facebook/AsyncDisplayKit/blob/7b112a2dcd0391ddf3671f9dcb63521f554b78bd/AsyncDisplayKit/ASCollectionView.mm#L34-L53
 */
static BOOL isInterceptedSelector(SEL sel) {
    return (
            // UITableViewDataSource
            sel == @selector(tableView:cellForRowAtIndexPath:) ||
            sel == @selector(tableView:numberOfRowsInSection:) ||
            sel == @selector(numberOfSectionsInTableView:) ||
            // UITableViewDelegate
            sel == @selector(tableView:heightForRowAtIndexPath:) ||
            sel == @selector(tableView:heightForHeaderInSection:) ||
            sel == @selector(tableView:heightForFooterInSection:) ||
            sel == @selector(tableView:viewForHeaderInSection:) ||
            sel == @selector(tableView:viewForFooterInSection:)
            );
}

@implementation WBTableViewDelegateProxy {
    __weak id _tableDataSourceTarget;
    __weak id _tableDelegateTarget;
    __weak id _interceptor;
}

- (instancetype)initWithTableDataSourceTarget:(id<UITableViewDataSource>)dataSource
                          tableDelegateTarget:(id<UITableViewDelegate>)delegate
                                  interceptor:(id)interceptor {
    WBListKitAssert(interceptor, @"interceptor不能为nil");
    
    _tableDataSourceTarget = dataSource;
    _tableDelegateTarget = delegate;
    _interceptor = interceptor;
    
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return isInterceptedSelector(aSelector)
    || [_tableDataSourceTarget respondsToSelector:aSelector]
    || [_tableDelegateTarget respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (isInterceptedSelector(aSelector)) {
        return _interceptor;
    }
    if ([_tableDelegateTarget respondsToSelector:aSelector]) {
        return _tableDelegateTarget;
    }
    return _tableDataSourceTarget;
}

// handling unimplemented methods and nil target/interceptor
// https://github.com/Flipboard/FLAnimatedImage/blob/76a31aefc645cc09463a62d42c02954a30434d7d/FLAnimatedImage/FLAnimatedImage.m#L786-L807
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end
