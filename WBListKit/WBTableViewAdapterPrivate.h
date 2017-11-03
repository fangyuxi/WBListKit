//
//  WBTableViewAdapterPrivate.h
//  Pods
//
//  Created by fangyuxi on 2017/5/16.
//
//

//#import "WBTableViewAdapter.h"

@protocol WBListActionToControllerProtocol;

/**
 隐藏，防止外部访问到
 */
@class WBTableUpdater;
@interface WBTableViewAdapter ()

@property (nonatomic, weak) id<WBListActionToControllerProtocol> actionDelegate;
@property (nonatomic, weak) id<UITableViewDataSource> tableDataSource;
@property (nonatomic, weak, readwrite) UITableView *tableView;

- (void)willAppear;
- (void)didDisappear;

/**
 标识是否在differ中
 */
@property (nonatomic, assign) BOOL isInDifferring;

/**
 differ之前的旧数据
 */
@property (nonatomic, strong) NSMutableArray *oldSections;

/**
 tableview 更新对象
 */
@property (nonatomic, strong) WBTableUpdater *updater;

/**
 当前的section数组
 */
@property (nonatomic, strong) NSMutableArray *sections;

/**
 重置所有section和row的记录，同步old和new
 */
- (void)resetAllSectionsAndRowsRecords;

@end

