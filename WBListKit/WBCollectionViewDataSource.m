//
//  WBCollectionViewDataSource.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/29.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBCollectionViewDataSource.h"
#import "WBCollectionViewDataSourcePrivate.h"
#import "WBCollectionViewAdapterPrivate.h"
#import "UICollectionView+WBListKitPrivate.h"

@implementation WBCollectionViewDataSource

@synthesize collectionViewAdapter = _collectionViewAdapter;

- (void)bindCollectionView:(nullable UICollectionView *)collectionView{
    [self.collectionViewAdapter unBindCollectionView];
    self.collectionView = collectionView;
    self.collectionView.source = self;
    if (collectionView) {
        [self.collectionViewAdapter bindCollectionView:collectionView];
    }
}

- (void)unBindCollectionView{
    [self.collectionViewAdapter unBindCollectionView];
    self.collectionView.source = nil;
    self.collectionView = nil;
}

- (WBCollectionViewAdapter *)collectionViewAdapter{
    if (!_collectionViewAdapter) {
        _collectionViewAdapter = [WBCollectionViewAdapter new];
    }
    return _collectionViewAdapter;
}


@end
