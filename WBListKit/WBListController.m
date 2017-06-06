//
//  WBListController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/28.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBListController.h"
#import "WBListRefreshControlCallbackProtocol.h"

@interface WBListController ()<WBListRefreshControlCallbackProtocol>

@property (nonatomic, strong, nullable, readwrite) UIViewController *viewController;

@end

@implementation WBListController

- (nullable instancetype)initWithController:(nonnull UIViewController *)viewController{
    self = [super init];
    self.viewController = viewController;
    return self;
}

#pragma mark setters

- (void)setRefreshHeaderView:(id<WBListRefreshHeaderViewProtocol>)refreshHeaderView{
    _refreshHeaderView = refreshHeaderView;
    [_refreshHeaderView attachToView:[self getCurrentView] callbackTarget:self];
}

- (void)setLoadMoreFooterView:(id<WBListRefreshFooterViewProtocol>)loadMoreFooterView{
    _loadMoreFooterView = loadMoreFooterView;
    [_loadMoreFooterView attachToView:[self getCurrentView] callbackTarget:self];
}

- (void)setTableView:(UITableView *)tableView{
    if (tableView) {
        NSAssert(!self.collectionView, @"不能同时存在UITableView和UICollectionView");
    }
    _tableView = tableView;
    if (self.refreshHeaderView) {
        [self.refreshHeaderView attachToView:[self getCurrentView] callbackTarget:self];
    }
    if (self.loadMoreFooterView) {
        [self.loadMoreFooterView attachToView:[self getCurrentView] callbackTarget:self];
    }
}

- (void)setCollectionView:(UICollectionView *)collectionView{
    if (collectionView) {
        NSAssert(!self.tableView, @"不能同时存在UITableView和UICollectionView");
    }
    _collectionView = collectionView;
    if (self.refreshHeaderView) {
        [self.refreshHeaderView attachToView:[self getCurrentView] callbackTarget:self];
    }
    if (self.loadMoreFooterView) {
        [self.loadMoreFooterView attachToView:[self getCurrentView] callbackTarget:self];
    }
}

#pragma mark MJRefresh CallBack

- (void)refreshControlBeginRefreshing{
    [[self getCurrentSource] loadSource];
}

- (void)refreshControlBeginLoadMore{
    [[self getCurrentSource] loadMoreSource];
}

#pragma mark controller refresh source

- (void)dragToRefresh{
    [self.refreshHeaderView begin];
}

- (void)refreshImmediately{
    [self refreshControlBeginRefreshing];
}

#pragma mark dataSource delegate

- (void)sourceDidStartLoad:(WBListDataSource *)tableSource{
    //下拉刷新的时候禁止上拉
    [self.loadMoreFooterView disable];
}

- (void)sourceDidFinishLoad:(WBListDataSource *)tableSource{
    [self.refreshHeaderView end];
    [self toggleFooterMoreDataState];
    [(UITableView *)[self getCurrentView] reloadData];
}

- (void)sourceDidStartLoadMore:(WBListDataSource *)tableSource{
    [self.refreshHeaderView disable];
}

- (void)sourceDidFinishLoadMore:(WBListDataSource *)tableSource{
    //[[self getCurrentView].mj_footer endRefreshing];
    [self.loadMoreFooterView end];
    if (self.refreshHeaderView) {
        [self.refreshHeaderView enable];
    }
    [self toggleFooterMoreDataState];
    [(UITableView *)[self getCurrentView] reloadData];
}

- (void)source:(WBListDataSource *)tableSource loadError:(NSError *)error{
    [self.refreshHeaderView end];
    [self toggleFooterMoreDataState];
}

- (void)source:(WBListDataSource *)tableSource loadMoreError:(NSError *)error{
    [self.loadMoreFooterView end];
    [self toggleFooterMoreDataState];
}

- (void)source:(WBListDataSource *)source didReceviedExtraData:(id)data{
}

- (void)sourceDidClearAllData:(WBListDataSource *)tableSource{
}

- (void)toggleFooterMoreDataState{
    if (self.loadMoreFooterView) {
        if ([self getCurrentSource].canLoadMore) {
            [self.loadMoreFooterView enable];
            [self.loadMoreFooterView resetToNormalState];
        }else{
            [self.loadMoreFooterView endWithNoMoreDataState];
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
