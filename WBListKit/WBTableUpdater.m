//
//  WBTableUpdater.m
//  Pods
//
//  Created by fangyuxi on 2017/6/13.
//
//

#import "WBTableUpdater.h"
#import "IGListDiffKit.h"
#import "WBTableViewAdapter.h"
#import "WBTableSectionPrivate.h"

@implementation WBTableUpdater

- (void)diffSectionsInTableView:(UITableView *)view
                           from:(NSArray<id<WBListDiffableProtocol>> *)from
                             to:(NSArray<id<WBListDiffableProtocol>> *)to
                      animation:(BOOL)animation{
    
    IGListIndexSetResult *result = IGListDiffExperiment(from, to, IGListDiffEquality, IGListExperimentNone);
    if (result.deletes.count == 0 &&
        result.inserts.count == 0 &&
        result.moves.count == 0) {
        return;
    }
    if (animation) {
        [view beginUpdates];
        [view deleteSections:result.deletes withRowAnimation:UITableViewRowAnimationFade];
        for (IGListMoveIndex *move in result.moves) {
            [view moveSection:move.from toSection:move.to];
        }
        [view insertSections:result.inserts withRowAnimation:UITableViewRowAnimationFade];
        [view endUpdates];
    }else{
        [UIView performWithoutAnimation:^{
            [view beginUpdates];
            [view deleteSections:result.deletes withRowAnimation:UITableViewRowAnimationTop];
            for (IGListMoveIndex *move in result.moves) {
                [view moveSection:move.from toSection:move.to];
            }
            [view insertSections:result.inserts withRowAnimation:UITableViewRowAnimationTop];
            [view endUpdates];
        }];
    }
}

- (void)diffRowsInTableView:(UITableView *)view
                  ofSection:(NSInteger)section
                       from:(NSArray<id<WBListDiffableProtocol>> *)from
                         to:(NSArray<id<WBListDiffableProtocol>> *)to
                  animation:(BOOL)animation{
    IGListIndexPathResult *result = IGListDiffPathsExperiment(section, section, from, to, IGListDiffEquality, IGListExperimentNone);
    
    if (result.deletes.count == 0 &&
        result.inserts.count == 0 &&
        result.moves.count == 0 &&
        result.updates.count == 0) {
        return;
    }
    
    if (animation) {
        [view beginUpdates];
        [view deleteRowsAtIndexPaths:result.deletes withRowAnimation:UITableViewRowAnimationAutomatic];
        for (IGListMoveIndexPath *move in result.moves) {
            [view moveRowAtIndexPath:move.from toIndexPath:move.to];
        }
        [view insertRowsAtIndexPaths:result.inserts withRowAnimation:UITableViewRowAnimationAutomatic];
        [view reloadRowsAtIndexPaths:result.updates withRowAnimation:UITableViewRowAnimationAutomatic];
        [view endUpdates];
    }else{
        [UIView performWithoutAnimation:^{
            [view beginUpdates];
            [view deleteRowsAtIndexPaths:result.deletes withRowAnimation:UITableViewRowAnimationNone];
            for (IGListMoveIndexPath *move in result.moves) {
                [view moveRowAtIndexPath:move.from toIndexPath:move.to];
            }
            [view insertRowsAtIndexPaths:result.inserts withRowAnimation:UITableViewRowAnimationNone];
            [view reloadRowsAtIndexPaths:result.updates withRowAnimation:UITableViewRowAnimationNone];
            [view endUpdates];
        }];
    }
}

- (void)diffSectionsAndRowsInTableView:(UITableView *)view
                                  from:(NSArray<id<WBListDiffableProtocol>> *)from
                                    to:(NSArray<id<WBListDiffableProtocol>> *)to
                             animation:(BOOL)animation{
    
    //diff section
    [self diffSectionsInTableView:view from:from to:to animation:animation];
    
    //diff row
    [to enumerateObjectsUsingBlock:^(id<WBListDiffableProtocol>  _Nonnull obj,
                                     NSUInteger idx,
                                     BOOL * _Nonnull stop) {
        
        WBTableSection *section = (WBTableSection *)obj;
        if ([from containsObject:section]) {
            [self diffRowsInTableView:view
                            ofSection:idx
                                 from:section.oldArray
                                   to:section.rows
                            animation:animation];
        }
        
    }];
}

@end
