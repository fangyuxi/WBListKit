//
//  WBTableViewAdapterPrivate.h
//  Pods
//
//  Created by Romeo on 2017/5/16.
//
//

//#import "WBTableViewAdapter.h"

@protocol WBListActionToControllerProtocol;

/**
 隐藏这个属性，防止外部访问到
 */
@interface WBTableViewAdapter ()

@property (nonatomic, weak) id<WBListActionToControllerProtocol> actionDelegate;

/**
 绑定tableView
 当Adapter和TableView出现多对一情况的时候，重新绑定即可
 @param tableView 'tableView'
 */
- (void)bindTableView:(UITableView *)tableView;

/**
 解绑TableView
 */
- (void)unBindTableView;

@end

