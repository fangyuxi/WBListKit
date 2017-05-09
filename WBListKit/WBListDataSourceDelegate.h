//
//  WBListDataSourceDelegate.h
//  WBListKit
//
//  Created by fangyuxi on 2017/3/24.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBListDataSource;

@protocol WBListDataSourceDelegate <NSObject>

@optional

- (void)sourceDidStartLoad:(WBListDataSource *)tableSource;
- (void)sourceDidFinishLoad:(WBListDataSource *)tableSource ;
- (void)sourceDidStartLoadMore:(WBListDataSource *)tableSource;
- (void)sourceDidFinishLoadMore:(WBListDataSource *)tableSource;

- (void)source:(WBListDataSource *)tableSource loadError:(NSError *)error;
- (void)source:(WBListDataSource *)tableSource loadMoreError:(NSError *)error;
- (void)source:(WBListDataSource *)source didReceviedExtraData:(id)data;

- (void)sourceDidClearAllData:(WBListDataSource *)tableSource;

@end
