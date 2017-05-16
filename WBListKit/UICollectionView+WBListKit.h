//
//  UITableView+WBListKit.h
//  Pods
//
//  Created by Romeo on 2017/5/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@protocol WBListActionToControllerProtocol;

@interface UICollectionView (WBListKit)

@property (nonatomic, weak, nullable) id<WBListActionToControllerProtocol> actionDelegate;

@end
