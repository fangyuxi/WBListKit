//
//  WBTableViewDataSourcePrivate.h
//  Pods
//
//  Created by Romeo on 2017/5/19.
//
//

#import "WBTableViewDataSource.h"
/**
 隐藏
 */
@interface WBTableViewDataSource()

/**
 display data on
 set this property to bind tableview on this datasource
 */
@property (nonatomic, weak, readwrite, nullable) UITableView *tableView;

/**
 绑定tableView
 当DataSource和TableView出现多对一情况的时候
 在使用指定的DataSource之前，需要重新绑定
 @param tableView 'tableView'
 */
- (void)bindTableView:(nullable UITableView *)tableView;
- (void)unBindTableView;

@end
