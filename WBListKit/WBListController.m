//
//  WBListController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/28.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBListController.h"
#import "WBListRefreshControlCallbackProtocol.h"
#import "UITableView+WBListKit.h"
#import "UICollectionView+WBListKit.h"

@interface WBListController ()<WBListRefreshControlCallbackProtocol>

@property (nonatomic, strong, nullable, readwrite) UIViewController *viewController;

@end

@implementation WBListController

- (nullable instancetype)initWithController:(nonnull UIViewController *)viewController{
    self = [super init];
    _viewController = viewController;
    return self;
}

#pragma mark setters

- (void)setRefreshHeaderControl:(id<WBListRefreshHeaderViewProtocol>)refreshHeaderView{
    _refreshHeaderControl = refreshHeaderView;
    [_refreshHeaderControl attachToView:[self getCurrentView] callbackTarget:self];
}

- (void)setLoadMoreFooterControl:(id<WBListRefreshFooterViewProtocol>)loadMoreFooterView{
    _loadMoreFooterControl = loadMoreFooterView;
    [_loadMoreFooterControl attachToView:[self getCurrentView] callbackTarget:self];
}

- (void)setTableView:(UITableView *)tableView{
    if (tableView) {
        WBListKitAssert(!self.collectionView, @"不能同时存在UITableView和UICollectionView");
    }
    _tableView = tableView;
    if (self.refreshHeaderControl) {
        [self.refreshHeaderControl attachToView:[self getCurrentView] callbackTarget:self];
    }
    if (self.loadMoreFooterControl) {
        [self.loadMoreFooterControl attachToView:[self getCurrentView] callbackTarget:self];
    }
}

- (void)setCollectionView:(UICollectionView *)collectionView{
    if (collectionView) {
        WBListKitAssert(!self.tableView, @"不能同时存在UITableView和UICollectionView");
    }
    _collectionView = collectionView;
    if (self.refreshHeaderControl) {
        [self.refreshHeaderControl attachToView:[self getCurrentView] callbackTarget:self];
    }
    if (self.loadMoreFooterControl) {
        [self.loadMoreFooterControl attachToView:[self getCurrentView] callbackTarget:self];
    }
}

- (void)setTableDataSource:(WBTableViewDataSource *)tableDataSource{
    if (tableDataSource) {
        WBListKitAssert(!self.collectionDataSource, @"不能同时存在UITableViewSource和UICollectionViewSource");
    }
    _tableDataSource = tableDataSource;
}

- (void)setCollectionDataSource:(WBCollectionViewDataSource *)collectionDataSource{
    if (collectionDataSource) {
        WBListKitAssert(!self.tableDataSource, @"不能同时存在UITableViewSource和UICollectionViewSource");
    }
    _collectionDataSource = collectionDataSource;
}

#pragma mark WBListRefresh & LoadMore Control CallBack

- (void)refreshControlBeginRefreshing{
    [[self getCurrentSource] loadSource];
}

- (void)refreshControlBeginLoadMore{
    [[self getCurrentSource] loadMoreSource];
}

#pragma mark controller refresh source

- (void)dragToRefresh{
    [self.refreshHeaderControl begin];
}

- (void)refreshImmediately{
    [self refreshControlBeginRefreshing];
}

- (void)dragToLoadMore{
    [self.loadMoreFooterControl begin];
}

- (void)loadMoreImmediately{
    [self refreshControlBeginLoadMore];
}

#pragma mark dataSource delegate

- (void)sourceDidStartLoad:(WBListDataSource *)tableSource{
    //下拉刷新的时候禁止上拉
    [self.loadMoreFooterControl disable];
}

- (void)sourceDidFinishLoad:(WBListDataSource *)tableSource{
    [self.refreshHeaderControl end];
    [self toggleFooterMoreDataState];
    if (self.tableView) {
        [self.tableView reloadDifferWithAnimation:NO];
    }else if (self.collectionView){
        [self.collectionView reloadDifferWithAnimation:NO];
    }
}

- (void)sourceDidStartLoadMore:(WBListDataSource *)tableSource{
    [self.refreshHeaderControl disable];
}

- (void)sourceDidFinishLoadMore:(WBListDataSource *)tableSource{
    [self.loadMoreFooterControl end];
    if (self.refreshHeaderControl) {
        [self.refreshHeaderControl enable];
    }
    [self toggleFooterMoreDataState];
    
    if (self.tableView) {
        [self.tableView reloadDifferWithAnimation:NO];
    }else if (self.collectionView){
        [self.collectionView reloadDifferWithAnimation:NO];
    }
}

- (void)source:(WBListDataSource *)tableSource loadError:(NSError *)error{
    [self.refreshHeaderControl end];
    [self toggleFooterMoreDataState];
}

- (void)source:(WBListDataSource *)tableSource loadMoreError:(NSError *)error{
    [self.loadMoreFooterControl end];
    [self toggleFooterMoreDataState];
}

- (void)source:(WBListDataSource *)source didReceviedExtraData:(id)data{
}

- (void)sourceDidClearAllData:(WBListDataSource *)tableSource{
}

- (void)toggleFooterMoreDataState{
    if (self.loadMoreFooterControl) {
        if ([self getCurrentSource].canLoadMore) {
            [self.loadMoreFooterControl enable];
            [self.loadMoreFooterControl resetToNormalState];
        }else{
            [self.loadMoreFooterControl endWithNoMoreDataState];
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
