//
//  WBCollectionViewDataSource.h
//  WBListKit
//
//  Created by fangyuxi on 2017/3/29.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBListDataSource.h"
#import "WBCollectionViewAdapter.h"

@interface WBCollectionViewDataSource : WBListDataSource

/**
 WBCollectionViewDataSource会自动创建一个适合于UICollectionView的Adapter,当数据加载完毕后
 我们可以通过这个adapter将数据交给UICollectionView
 */
@property (nonatomic, strong, readonly, nullable) WBCollectionViewAdapter *collectionViewAdapter;

@end
