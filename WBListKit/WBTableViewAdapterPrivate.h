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
@class WBTableUpdater;
@interface WBTableViewAdapter ()

@property (nonatomic, weak) id<WBListActionToControllerProtocol> actionDelegate;
@property (nonatomic, weak, readwrite) UITableView *tableView;

@property (nonatomic, assign) BOOL isInDifferring;
@property (nonatomic, strong) NSMutableArray *oldSections; // used for diff
@property (nonatomic, strong) WBTableUpdater *updater;
@property (nonatomic, strong) NSMutableArray *sections;

/**
 重置所有section和row的记录，同步old和new
 */
- (void)resetAllSectionsAndRowsRecords;

///**
// 绑定tableView
// 当Adapter和TableView出现多对一情况的时候，重新绑定即可
// @param tableView 'tableView'
// */
//- (void)bindTableView:(UITableView *)tableView;
//
///**
// 解绑TableView
// */
//- (void)unBindTableView;

@end

