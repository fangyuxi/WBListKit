//
//  WBCollectionViewAdapter.h
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WBListActionToControllerProtocol;

@interface WBCollectionViewAdapter : NSObject

/**
 bind UICollectionView

 @param collectionView 'UICollectionView'
 */
- (void)bindCollectionView:(UICollectionView *)collectionView;

/**
 unbind UICollectionView
 you can use this method to manage multi adapter binding one collectionView
 */
- (void)unBindCollectionView;

/**
 可以在'viewWillAppear' 和 'viewDidDisappear' 中调用，用来回调item supplementaryView
 中的 'cancel' 'reload' 方法
 */
- (void)willAppear;
- (void)didDisappear;

@property (nonatomic, weak, readonly) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
