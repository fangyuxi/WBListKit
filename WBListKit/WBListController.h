//
//  WBListController.h
//  WBListKit
//
//  Created by fangyuxi on 2017/3/28.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBTableViewDataSource.h"
#import "WBCollectionViewDataSource.h"
#import "WBListDataSourceDelegate.h"
#import "WBListRefreshHeaderViewProtocol.h"
#import "WBListRefreshFooterViewProtocol.h"

// 可以理解为一个UIViewController的代理对象，避免了业务方需要继承一个基类控制器

// notice !!! 请不要将UITableView和UICollectionView一起用，
//            如果您的页面设计中存在两个列表，那么创建两个子控制器
//            可能是个更好的选择


@interface WBListController : NSObject<WBListDataSourceDelegate>

/**
 创建列表控制器

 @param viewController 'UIViewController'
 @return listController
 */
- (nullable instancetype)initWithController:(nonnull UIViewController *)viewController;

/**
 refresh
 */
- (void)dragToRefresh; //会引发refreshHeaderControl的刷新动画(调用refreshHeaderControl中的begin方法)
- (void)refreshImmediately; //直接刷新数据源，不会引发refreshHeaderControl变化

/**
 提供一个WBTableViewDataSource和UITableView
 注意不能同时存在UITableView和UICollectionView，如果同时存在会产生异常
 */
@property (nonatomic, strong, nullable) WBTableViewDataSource *tableDataSource;
@property (nonatomic, strong, nullable) UITableView *tableView;

/**
 提供一个WBCollectionViewDataSource和UICollectionView
 注意不能同时存在UITableView和UICollectionView，如果同时存在会产生异常
 */
@property (nonatomic, strong, nullable) WBCollectionViewDataSource *collectionDataSource;
@property (nonatomic, strong, nullable) UICollectionView *collectionView;


/**
 集成下拉刷新和上拉加载更多的接口，框架内部会在合适的时机调用接口中定义的方法
 */
@property (nonatomic, strong, nullable) id<WBListRefreshHeaderViewProtocol> refreshHeaderControl;
@property (nonatomic, strong, nullable) id<WBListRefreshFooterViewProtocol> loadMoreFooterControl;

@end
