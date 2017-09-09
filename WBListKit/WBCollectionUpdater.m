//
//  WBCollectionUpdater.m
//  WBListKit
//
//  Created by fangyuxi on 2017/6/16.
//

#import "WBCollectionUpdater.h"
#import "IGListDiffKit.h"
#import "WBCollectionViewAdapter.h"
#import "WBCollectionSectionPrivate.h"


@implementation WBCollectionUpdater

- (void)diffSectionsInCollectionView:(UICollectionView *)view
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
        [view performBatchUpdates:^{
            for (IGListMoveIndex *move in result.moves) {
                [view moveSection:move.from toSection:move.to];
            }
            [view deleteSections:result.deletes];
            [view insertSections:result.inserts];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView performWithoutAnimation:^{
            [view performBatchUpdates:^{
                for (IGListMoveIndex *move in result.moves) {
                    [view moveSection:move.from toSection:move.to];
                }
                [view deleteSections:result.deletes];
                [view insertSections:result.inserts];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
}


- (void)diffRowsInCollectionView:(UICollectionView *)view
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
        [view performBatchUpdates:^{
            for (IGListMoveIndexPath *move in result.moves) {
                [view moveItemAtIndexPath:move.from toIndexPath:move.to];
            }
            [view reloadItemsAtIndexPaths:result.updates];
            [view deleteItemsAtIndexPaths:result.deletes];
            [view insertItemsAtIndexPaths:result.inserts];
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView performWithoutAnimation:^{
            [view performBatchUpdates:^{
                for (IGListMoveIndexPath *move in result.moves) {
                    [view moveItemAtIndexPath:move.from toIndexPath:move.to];
                }
                [view reloadItemsAtIndexPaths:result.updates];
                [view deleteItemsAtIndexPaths:result.deletes];
                [view insertItemsAtIndexPaths:result.inserts];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
}

//differ all
- (void)diffSectionsAndRowsInCollectionView:(UICollectionView *)view
                                       from:(NSArray<id<WBListDiffableProtocol>> *)from
                                         to:(NSArray<id<WBListDiffableProtocol>> *)to
                                  animation:(BOOL)animation{
    //diff section
    [self diffSectionsInCollectionView:view from:from to:to animation:animation];
    
    //diff row
    [to enumerateObjectsUsingBlock:^(id<WBListDiffableProtocol>  _Nonnull obj,
                                     NSUInteger idx,
                                     BOOL * _Nonnull stop) {
        
        WBCollectionSection *section = (WBCollectionSection *)obj;
        if ([from containsObject:section]) {
            [self diffRowsInCollectionView:view
                            ofSection:idx
                                 from:section.oldArray
                                   to:section.items
                            animation:animation];
        }
        
    }];
}
@end
