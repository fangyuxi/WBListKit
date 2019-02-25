//
//  UITableView+WBSizeManager.h
//  WBListKit
//
//  Created by fangyuxi on 2019/2/25.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "WBTableViewSizeManager.h"
#import "WBTableViewHeightCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView(WBHeightCache)

/// Height cache by index path. Generally, you don't need to use it directly.
@property (nonatomic, strong, readonly) WBTableViewHeightCache *wb_indexPathHeightCache;

@end

NS_ASSUME_NONNULL_END
