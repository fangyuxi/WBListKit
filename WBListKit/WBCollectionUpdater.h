//
//  WBCollectionUpdater.h
//  WBListKit
//
//  Created by fangyuxi on 2017/6/16.
//

#import <Foundation/Foundation.h>
#import "WBListDiffableProtocol.h"

@class WBCollectionUpdater;
@class WBCollectionSection;

@interface WBCollectionUpdater : NSObject

- (void)diffSectionsInCollectionView:(UICollectionView *)view
                           from:(NSArray<id<WBListDiffableProtocol>> *)from
                             to:(NSArray<id<WBListDiffableProtocol>> *)to
                      animation:(BOOL)animation;


- (void)diffRowsInCollectionView:(UICollectionView *)view
                  ofSection:(NSInteger)section
                       from:(NSArray<id<WBListDiffableProtocol>> *)from
                         to:(NSArray<id<WBListDiffableProtocol>> *)to
                  animation:(BOOL)animation;

//differ all
- (void)diffSectionsAndRowsInCollectionView:(UICollectionView *)view
                                       from:(NSArray<id<WBListDiffableProtocol>> *)from
                                         to:(NSArray<id<WBListDiffableProtocol>> *)to
                                  animation:(BOOL)animation;

@end
