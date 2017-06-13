//
//  WBTableUpdater.h
//  Pods
//
//  Created by Romeo on 2017/6/13.
//
//

#import <Foundation/Foundation.h>
#import "WBListDiffableProtocol.h"

@class WBTableViewAdapter;
@class WBTableSection;

@interface WBTableUpdater : NSObject

//differ section
- (void)updateDiffSectionInAdapter:(WBTableViewAdapter *)adapter
                 from:(NSArray<id<WBListDiffableProtocol>> *)from
                   to:(NSArray<id<WBListDiffableProtocol>> *)to;

//differ rows in section
- (void)updateDiffRowInSection:(WBTableSection *)section
                      from:(NSArray<id<WBListDiffableProtocol>> *)from
                        to:(NSArray<id<WBListDiffableProtocol>> *)to;

//differ all
- (void)updateDiffRowAndSectionInAdapter:(WBTableViewAdapter *)adapter
                                    from:(NSArray<id<WBListDiffableProtocol>> *)from
                                      to:(NSArray<id<WBListDiffableProtocol>> *)to;
@end
