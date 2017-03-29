//
//  WBCollectionViewAdapter.m
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import "WBCollectionViewAdapter.h"

@implementation WBCollectionViewAdapter

- (void)bindCollectionView:(UICollectionView *)collectionView{
    NSCAssert([collectionView isKindOfClass:[UICollectionView class]], @"bindCollectionView 需要一个 UITableView实例");
}

- (void)unBindCollectionView{
}

@end
