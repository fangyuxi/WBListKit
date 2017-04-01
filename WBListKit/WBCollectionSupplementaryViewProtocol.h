//
//  WBCollectionSupplementaryViewProtocol.h
//  Pods
//
//  Created by fangyuxi on 2017/4/1.
//
//

#ifndef WBCollectionSupplementaryViewProtocol_h
#define WBCollectionSupplementaryViewProtocol_h

#import "WBListReusableViewProtocol.h"

@class WBCollectionSupplementaryItem;

@protocol WBCollectionSupplementaryViewProtocol <WBListReusableViewProtocol>

@property (nonatomic, strong) WBCollectionSupplementaryItem *item;

@end

#endif /* WBCollectionSupplementaryViewProtocol_h */
