//
//  WBListController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/28.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBListController.h"

@interface WBListController ()

@property (nonatomic, strong, nullable, readwrite) UIViewController *viewController;

@end

@implementation WBListController

- (nullable instancetype)initWithController:(nonnull UIViewController *)viewController{
    self = [super init];
    self.viewController = viewController;
    return self;
}

#pragma mark setters

- (void)setRefreshHeaderView:(MJRefreshHeader *)refreshHeaderView{
    _refreshHeaderView = refreshHeaderView;
    [[self getCurrentView] setMj_header:refreshHeaderView];
    if (!refreshHeaderView.refreshingTarget) {
        refreshHeaderView.refreshingTarget = self;
    }
    if (!refreshHeaderView.refreshingAction) {
        refreshHeaderView.refreshingAction = @selector(refreshViewBeginRefreshing);
    }
}

- (void)setLoadMoreFooterView:(MJRefreshFooter *)loadMoreFooterView{
    _loadMoreFooterView = loadMoreFooterView;
    [[self getCurrentView] setMj_footer:loadMoreFooterView];
    if (!loadMoreFooterView.refreshingTarget) {
        loadMoreFooterView.refreshingTarget = self;
    }
    if (!loadMoreFooterView.refreshingAction) {
        loadMoreFooterView.refreshingAction = @selector(refreshViewBeginLoadMore);
    }
}

- (void)setTableView:(UITableView *)tableView{
    if (tableView) {
        NSAssert(!self.collectionView, @"不能同时存在UITableView和UICollectionView");
    }
    _tableView = tableView;
    if (self.refreshHeaderView) {
        [_tableView setMj_header:self.refreshHeaderView];
    }
    if (self.loadMoreFooterView) {
        [_tableView setMj_footer:self.loadMoreFooterView];
    }
}

- (void)setCollectionView:(UICollectionView *)collectionView{
    if (collectionView) {
        NSAssert(!self.tableView, @"不能同时存在UITableView和UICollectionView");
    }
    _collectionView = collectionView;
    if (self.refreshHeaderView) {
        [_collectionView setMj_header:self.refreshHeaderView];
    }
    if (self.loadMoreFooterView) {
        [_collectionView setMj_footer:self.loadMoreFooterView];
    }
}

#pragma mark MJRefresh CallBack

- (void)refreshViewBeginRefreshing{
    [[self getCurrentSource] loadSource];
}

- (void)refreshViewBeginLoadMore{
    [[self getCurrentSource] loadMoreSource];
}

#pragma mark controller refresh source

- (void)dragToRefresh{
    [[self getCurrentView].mj_header beginRefreshing];
}

- (void)refreshImmediately{
    [self refreshViewBeginRefreshing];
}

#pragma mark dataSource delegate

- (void)sourceDidStartLoad:(WBListDataSource *)tableSource{
    //下拉刷新的时候禁止上拉
    [self getCurrentView].mj_footer = nil;
}

- (void)sourceDidFinishLoad:(WBListDataSource *)tableSource{
    [[self getCurrentView].mj_header endRefreshing];
    [self toggleFooterMoreDataState];
    [(UITableView *)[self getCurrentView] reloadData];
}

- (void)sourceDidStartLoadMore:(WBListDataSource *)tableSource{
}

- (void)sourceDidFinishLoadMore:(WBListDataSource *)tableSource{
    [[self getCurrentView].mj_footer endRefreshing];
    [self toggleFooterMoreDataState];
    [(UITableView *)[self getCurrentView] reloadData];
}

- (void)source:(WBListDataSource *)tableSource loadError:(NSError *)error{
    [[self getCurrentView].mj_header endRefreshing];
    [self toggleFooterMoreDataState];
}

- (void)source:(WBListDataSource *)tableSource loadMoreError:(NSError *)error{
    [[self getCurrentView].mj_footer endRefreshing];
    [self toggleFooterMoreDataState];
}

- (void)source:(WBListDataSource *)source didReceviedExtraData:(id)data{
}

- (void)sourceDidClearAllData:(WBListDataSource *)tableSource{
}

- (void)toggleFooterMoreDataState{
    if (self.loadMoreFooterView) {
        if ([self getCurrentSource].canLoadMore) {
            self.loadMoreFooterView = self.loadMoreFooterView;
            [self.loadMoreFooterView resetNoMoreData];
        }else{
            [self.loadMoreFooterView endRefreshingWithNoMoreData];
        }
    }
}

#pragma mark private

- (WBListDataSource *)getCurrentSource{
    return self.tableDataSource ? self.tableDataSource : self.collectionDataSource;
}

- (UIScrollView *)getCurrentView{
    return self.tableView ? self.tableView : self.collectionView;
}

@end
