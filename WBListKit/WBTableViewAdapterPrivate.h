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

@end

