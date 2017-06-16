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

/**
 任何UICollectionView的Cell都应该遵循这个协议，然后合成item属性
 实现WBListReusableViewProtocol中的方法
 */
@class WBCollectionItem;

@protocol WBCollectionCellProtocol <WBListReusableViewProtocol>

@property (nonatomic, strong) WBCollectionItem *item;

@end

#endif /* WBCollectionCellProtocol_h */

