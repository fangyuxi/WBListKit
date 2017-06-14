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
#import "WBTableSectionPrivate.h"

@implementation WBTableUpdater

- (void)diffSectionsInTableView:(UITableView *)view
                           from:(NSArray<id<WBListDiffableProtocol>> *)from
                             to:(NSArray<id<WBListDiffableProtocol>> *)to{
    
    IGListIndexSetResult *result = IGListDiffExperiment(from, to, IGListDiffEquality, IGListExperimentNone);
    if (result.deletes.count == 0 &&
        result.inserts.count == 0 &&
        result.moves.count == 0) {
        return;
    }
    [view beginUpdates];
    for (IGListMoveIndex *move in result.moves) {
        [view moveSection:move.from toSection:move.to];
    }
    [view deleteSections:result.deletes withRowAnimation:UITableViewRowAnimationTop];
    [view insertSections:result.inserts withRowAnimation:UITableViewRowAnimationTop];
    [view endUpdates];
}

- (void)diffRowsInTableView:(UITableView *)view
                  ofSection:(NSInteger)section
                       from:(NSArray<id<WBListDiffableProtocol>> *)from
                         to:(NSArray<id<WBListDiffableProtocol>> *)to{
    IGListIndexPathResult *result = IGListDiffPathsExperiment(section, section, from, to, IGListDiffEquality, IGListExperimentNone);
    
    if (result.deletes.count == 0 &&
        result.inserts.count == 0 &&
        result.moves.count == 0) {
        return;
    }
    
    [view beginUpdates];
    for (IGListMoveIndexPath *move in result.moves) {
        [view moveRowAtIndexPath:move.from toIndexPath:move.to];
    }
    [view deleteRowsAtIndexPaths:result.deletes withRowAnimation:UITableViewRowAnimationAutomatic];
    [view insertRowsAtIndexPaths:result.inserts withRowAnimation:UITableViewRowAnimationAutomatic];
    [view endUpdates];
}

- (void)diffSectionsAndRowsInTableView:(UITableView *)view
                                  from:(NSArray<id<WBListDiffableProtocol>> *)from
                                    to:(NSArray<id<WBListDiffableProtocol>> *)to{
    
    //diff section
    [self diffSectionsInTableView:view from:from to:to];
    
    //diff row
    [to enumerateObjectsUsingBlock:^(id<WBListDiffableProtocol>  _Nonnull obj,
                                     NSUInteger idx,
                                     BOOL * _Nonnull stop) {
        
        WBTableSection *section = (WBTableSection *)obj;
        if ([from containsObject:section]) {
            [self diffRowsInTableView:view
                            ofSection:idx
                                 from:section.oldArray
                                   to:section.rows];
        }
        
    }];
}

@end
