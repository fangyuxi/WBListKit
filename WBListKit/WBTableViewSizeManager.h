//
//  WBTableViewSizeManager.h
//  WBListKit
//
//  Created by fangyuxi on 2019/2/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBTableViewSizeManager : NSObject

+ (instancetype)sharedManager;

- (CGFloat)heightForCellWithIdentifier:(NSString *)identifier
                   registeredTableView:(UITableView *)tableView
                      cacheByIndexPath:(NSIndexPath *)indexPath
                         configuration:(void (^)(id cell))configuration;

@end

NS_ASSUME_NONNULL_END
