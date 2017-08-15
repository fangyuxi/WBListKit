//
//  UITableView+WBListKit.h
//  Pods
//
//  Created by Romeo on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@class WBTableViewAdapter;
@class WBTableViewDataSource;
@protocol WBListActionToControllerProtocol;


@interface UITableView (WBListKit)

/**
 绑定adapter
 */
@property (nonatomic, nullable) WBTableViewAdapter *adapter;

/**
 取代UITableView的delegate
 增加了从Cell到自定义代理对象的事件传递
 在Cell中合成actionDelegate属性，通过
 actionDelegate属性，传递到想传递的地方（通常是控制器）
 */
@property (nonatomic, weak, nullable) id<WBListActionToControllerProtocol> actionDelegate;

/**
 取代UITableView的dataSource
 禁用UITableView的delegate和datasource，
 如果遇到特殊情况想指定datasource,比如：
 `canEditRowAtIndexPath`
 `sectionIndexTitlesForTableView`
 `sectionForSectionIndexTitle`
 `commitEditingStyle`
 
 那么请使用这个属性代替
 */
@property (nonatomic, weak, nullable) id<UITableViewDataSource> tableDataSource;

/**
 可以在'viewWillAppear' 和 'viewDidDisappear' 中调用
 用来回调cell/header/footer 中的 'cancel' 'reload' 方法
 */
- (void)willAppear;
- (void)didDisappear;

/**
 绑定TableViewSource
 @param source 'source'
 */
- (void)bindViewDataSource:(nonnull WBTableViewDataSource *)source;
- (void)unbindViewDataSource;

/** 以下方法同Adapter **/
- (void)beginAutoDiffer;
- (void)commitAutoDifferWithAnimation:(BOOL)animation;
- (void)reloadDifferWithAnimation:(BOOL)animation;

@end
