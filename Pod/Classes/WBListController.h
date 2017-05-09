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
#import "MJRefresh/MJRefresh.h"

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
 结合了MJRefresh实现上拉下拉刷新，在针对不同的业务的时候，可以自己定制样式
 暂时不支持脱离MJRefresh使用，如果有自己已经定义的header，可以考虑继承一个
 MJRefreshHeaderFooter，将已经实现好的header贴到MJ中
 */
@property (nonatomic, strong, nullable) MJRefreshHeader *refreshHeaderView;
@property (nonatomic, strong, nullable) MJRefreshFooter *loadMoreFooterView;

/**
 refresh
 */
- (void)dragToRefresh;
- (void)refreshImmediately;

@end
