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

@end
