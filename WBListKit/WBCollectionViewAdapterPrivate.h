//
//  WBCollectionViewAdapterPrivate.h
//  Pods
//
//  Created by Romeo on 2017/5/16.
//
//


/**
 隐藏这个属性，防止外部访问到
 */
@protocol WBListActionToControllerProtocol;

@interface WBCollectionViewAdapter ()

@property (nonatomic, weak) id<WBListActionToControllerProtocol> actionDelegate;


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

@end
