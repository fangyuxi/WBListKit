//
//  WBCollectionViewDelegateProxy.m
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import "WBCollectionViewDelegateProxy.h"
#import "WBListKitAssert.h"

/**
 Define messages that you want the adapter object to intercept. Pattern copied from
 https://github.com/facebook/AsyncDisplayKit/blob/7b112a2dcd0391ddf3671f9dcb63521f554b78bd/AsyncDisplayKit/ASCollectionView.mm#L34-L53
 */
static BOOL isInterceptedSelector(SEL sel) {
    return (
            // UICollectionViewDataSource
            sel == @selector(collectionView:cellForItemAtIndexPath:) ||
            sel == @selector(collectionView:numberOfItemsInSection:) ||
            sel == @selector(numberOfSectionsInCollectionView:) ||
            sel == @selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)
            );
}

@implementation WBCollectionViewDelegateProxy{
    __weak id _collectionDataSourceTarget;
    __weak id _collectionDelegateTarget;
    __weak id _interceptor;
}

- (instancetype)initWithCollectionViewDataSourceTarget:(id<UICollectionViewDataSource>)dataSource
                          collectionViewDelegateTarget:(id<UICollectionViewDelegate>)delegate
                                           interceptor:(id)interceptor{
    self = [super init];
    NSAssert(interceptor, @"interceptor不能为nil");
    
    _collectionDataSourceTarget = dataSource;
    _collectionDelegateTarget = delegate;
    _interceptor = interceptor;
    
    return self;
    
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return isInterceptedSelector(aSelector)
    || [_collectionDataSourceTarget respondsToSelector:aSelector]
    || [_collectionDelegateTarget respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (isInterceptedSelector(aSelector)) {
        return _interceptor;
    }
    if ([_collectionDelegateTarget respondsToSelector:aSelector]) {
        return _collectionDelegateTarget;
    }
    if([_collectionDataSourceTarget respondsToSelector:aSelector]) {
        return _collectionDataSourceTarget;
    }
    return nil;
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
