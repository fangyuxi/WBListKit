//
//  WBCollectionViewDelegateProxy.h
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitMacros.h"

NS_ASSUME_NONNULL_BEGIN

WBListKit_SUBCLASSING_RESTRICTED
@interface WBCollectionViewDelegateProxy : NSObject

- (instancetype)initWithCollectionViewDataSourceTarget:(id<UICollectionViewDataSource>)dataSource
                          collectionViewDelegateTarget:(id<UICollectionViewDelegate>)delegate
                                           interceptor:(id)interceptor;

@end

NS_ASSUME_NONNULL_END
