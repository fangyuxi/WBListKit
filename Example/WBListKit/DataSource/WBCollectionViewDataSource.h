//
//  WBCollectionViewDataSource.h
//  WBListKit
//
//  Created by fangyuxi on 2017/3/29.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBListDataSource.h"

@interface WBCollectionViewDataSource : WBListDataSource

/**
 WBCollectionViewDataSource会自动创建一个适合于UICollectionView的Adapter,当数据加载完毕后
 我们可以通过这个adapter将数据交给UICollectionView
 */
@property (nonatomic, strong, readonly, nullable) WBCollectionViewAdapter *collectionViewAdapter;

/**
 绑定collectionView
 当DataSource和collectionView出现多对一情况的时候
 在使用指定的DataSource之前，需要重新绑定
 @param collectionView 'collectionView'
 */
- (void)bindCollectionView:(nullable UICollectionView *)collectionView;
- (void)unBindCollectionView;

@end
