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
#import "MJRefresh.h"

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
 create a custom datasource instance inherited from WBTableViewDataSource
 you should provide a UITableView instance
 */
@property (nonatomic, strong, nullable) WBTableViewDataSource *tableDataSource;
@property (nonatomic, strong, nullable) UITableView *tableView;

/**
 create a custom datasource instance inherited from WBCollectionViewDataSource
 you should provide a UICollectionView instance
 */
@property (nonatomic, strong, nullable) WBCollectionViewDataSource *collectionDataSource;
@property (nonatomic, strong, nullable) UICollectionView *collectionView;


@property (nonatomic, strong, nullable) MJRefreshHeader *refreshHeaderView;
@property (nonatomic, strong, nullable) MJRefreshFooter *loadMoreFooterView;

/**
 refresh
 */
- (void)dragToRefresh;
- (void)refreshImmediately;

@end
