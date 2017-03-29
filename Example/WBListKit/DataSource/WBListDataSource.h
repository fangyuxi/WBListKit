//
//  WBListDataSource.h
//  WBListKit
//
//  Created by fangyuxi on 2017/3/22.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBListDataSourceDelegate.h"
#import "WBListKit.h"

/**
 usually you with no need for subclass directly
 
 you should use subclass 
 
 WBTableViewDataSource for UITableView
 WBCollectionViewDataSource for UICollectionView
 
 */
@interface WBListDataSource : NSObject

/**
 designated init method

 @param delegate 'WBListDataSourceDelegate'
 @return source
 */
- (nullable instancetype)initWithDelegate:(nonnull id<WBListDataSourceDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (nullable instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 in normal conditions,it will be controller object
 */
@property (nonatomic, weak, nullable, readonly) id<WBListDataSourceDelegate> delegate;
@property (nonatomic, weak, nullable) id<WBListActionToControllerProtocol> actionDelegate;

/**
 load data
 */
- (void)loadSource;
- (void)loadMoreSource;
- (void)cancelLoad;

/**
 需要根据数据情况，主动设置此选项，框架会根据此选项自动设置footer的状态
 */
@property (nonatomic, assign) BOOL canLoadMore;

@end


/**
 以下方法需要在合适的时机调用通知控制器
 */
@interface WBListDataSource (NotifyController)

- (void)notifyWillLoad;
- (void)notifyWillLoadMore;
- (void)notifyDidFinishLoad;
- (void)notifyDidFinishLoadMore;
- (void)notifyDidReceviedExtraData:(nonnull id)data;
- (void)notifyLoadError:(nonnull NSError *)error;
- (void)notifyLoadMoreError:(nonnull NSError *)error;
- (void)notifySourceDidClear;

@end


