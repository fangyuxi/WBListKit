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

/// Call this method when you want to reload data but don't want to invalidate
/// all height cache by index path, for example, load more data at the bottom of
/// table view.
- (void)wb_reloadDataWithoutInvalidateIndexPathHeightCache;
@end

NS_ASSUME_NONNULL_END
