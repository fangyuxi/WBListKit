//
//  WBCollectionCellProtocol.h
//  Pods
//
//  Created by fangyuxi on 2017/3/31.
//
//

#ifndef WBCollectionCellProtocol_h
#define WBCollectionCellProtocol_h

#import "WBListReusableViewProtocol.h"

@class WBCollectionItem;

@protocol WBCollectionCellProtocol <WBListReusableViewProtocol>

@property (nonatomic, strong) WBCollectionItem *item;

@end

#endif /* WBCollectionCellProtocol_h */
