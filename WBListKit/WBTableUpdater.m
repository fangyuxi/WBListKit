//
//  WBTableUpdater.m
//  Pods
//
//  Created by Romeo on 2017/6/13.
//
//

#import "WBTableUpdater.h"
#import "IGListDiffKit.h"
#import "WBTableViewAdapter.h"

@implementation WBTableUpdater

- (void)updateDiffSectionInAdapter:(WBTableViewAdapter *)adapter
                              from:(NSArray<id<WBListDiffableProtocol>> *)from
                                to:(NSArray<id<WBListDiffableProtocol>> *)to{
    
}

- (void)updateDiffRowInSection:(WBTableSection *)section
                          from:(NSArray<id<WBListDiffableProtocol>> *)from
                            to:(NSArray<id<WBListDiffableProtocol>> *)to{
    
}

- (void)updateDiffRowAndSectionInAdapter:(WBTableViewAdapter *)adapter
                                    from:(NSArray<id<WBListDiffableProtocol>> *)from
                                      to:(NSArray<id<WBListDiffableProtocol>> *)to{
    
    IGListIndexSetResult *result = IGListDiffExperiment(from, to, IGListDiffEquality, IGListExperimentNone);
    
    [adapter.tableView beginUpdates];
    for (IGListMoveIndex *move in result.moves) {
        [adapter.tableView moveSection:move.from toSection:move.to];
    }
    [adapter.tableView deleteSections:result.deletes withRowAnimation:UITableViewRowAnimationTop];
    [adapter.tableView insertSections:result.inserts withRowAnimation:UITableViewRowAnimationTop];
    [adapter.tableView endUpdates];
    
}

@end
