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

/**
 任何自定义的SupplementaryItem 都应该遵循这个协议，并合成item属性
 实现WBListReusableViewProtocol中的方法
 */
@class WBCollectionSupplementaryItem;

@protocol WBCollectionSupplementaryViewProtocol <WBListReusableViewProtocol>

@property (nonatomic, strong) WBCollectionSupplementaryItem *item;

@end

#endif /* WBCollectionSupplementaryViewProtocol_h */
