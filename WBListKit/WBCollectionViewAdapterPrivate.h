//
//  WBCollectionViewAdapterPrivate.h
//  Pods
//
//  Created by Romeo on 2017/5/16.
//
//


@protocol WBListActionToControllerProtocol;

@interface WBCollectionViewAdapter ()

@property (nonatomic, weak) id<WBListActionToControllerProtocol> actionDelegate;

@end
