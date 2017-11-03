//
//  WBTableUpdater.h
//  Pods
//
//  Created by fangyuxi on 2017/6/13.
//
//

#import <Foundation/Foundation.h>
#import "WBListDiffableProtocol.h"

@class WBTableViewAdapter;
@class WBTableSection;

@interface WBTableUpdater : NSObject

- (void)diffSectionsInTableView:(UITableView *)view
                 from:(NSArray<id<WBListDiffableProtocol>> *)from
                   to:(NSArray<id<WBListDiffableProtocol>> *)to
            animation:(BOOL)animation;


- (void)diffRowsInTableView:(UITableView *)view
                  ofSection:(NSInteger)section
                       from:(NSArray<id<WBListDiffableProtocol>> *)from
                         to:(NSArray<id<WBListDiffableProtocol>> *)to
                  animation:(BOOL)animation;

//differ all
- (void)diffSectionsAndRowsInTableView:(UITableView *)view
                                  from:(NSArray<id<WBListDiffableProtocol>> *)from
                                    to:(NSArray<id<WBListDiffableProtocol>> *)to
                             animation:(BOOL)animation;
@end
