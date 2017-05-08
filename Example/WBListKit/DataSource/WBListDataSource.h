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
 提供了Controller加载数据的统一接口
 提供了同Controller通信的统一接口
 搭配Adapter之后，可以将获取的数据经转化提供给UITableView/UICollectionView/XXXView 显示 
 
 通常来讲你不需要继承改写这个类，因为这类的每一个子类对应了一种不同的列表组织方式，目前iOS中
 仅存在UITableView 和 UICollectionView 所以目前有两个子类：
 
 UITableViewDataSource
 UICollectionViewDataSource
 
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
 通常，这个delegate应该为控制器，如果是控制器，那么在控制器的WBList分类中的list属性已经帮助我们
 实现了所有代理方法，list知道应该怎样处理数据层的回调。
 
 如果不是控制器，那么需要自己实现数据层的代理
 */
@property (nonatomic, weak, nullable, readonly) id<WBListDataSourceDelegate> delegate;
@property (nonatomic, weak, nullable) id<WBListActionToControllerProtocol> actionDelegate;

/**
 load data  子类需要重写以下三个方法
            在loadSource处理控制器发起的加载数据的请求
            在loadMoreSource中处理控制器发起的加载更多的请求，
            在cancelLoad中处理控制器发起的取消加载的请求
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


