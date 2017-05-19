//
//  UITableView+WBListKitPrivate.h
//  Pods
//
//  Created by Romeo on 2017/5/16.
//
//

#import <Foundation/Foundation.h>
#import "WBCollectionViewAdapter.h"

/**
 隐藏这个属性，防止外部访问到
 */
@class WBCollectionViewDataSource;
@interface UICollectionView (WBListKitPrivate)

@property (nonatomic, weak) WBCollectionViewAdapter *adapter;
@property (nonatomic, weak) WBCollectionViewDataSource *source;

@end
