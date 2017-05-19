//
//  WBCollectionViewDataSourcePrivate.h
//  Pods
//
//  Created by fangyuxi on 2017/5/20.
//
//

#import "WBCollectionViewDataSource.h"
/**
 隐藏
 */
@interface WBCollectionViewDataSource()

/**
 display data on
 set this property to bind tableview on this datasource
 */
@property (nonatomic, weak, readwrite, nullable) UICollectionView *collectionView;

/**
 绑定collectionView
 当DataSource和collectionView出现多对一情况的时候
 在使用指定的DataSource之前，需要重新绑定
 @param collectionView 'collectionView'
 */
- (void)bindCollectionView:(nullable UICollectionView *)collectionView;
- (void)unBindCollectionView;

@end

