//
//  WBCollectionViewAdapterPrivate.h
//  Pods
//
//  Created by Romeo on 2017/5/16.
//
//


/**
 隐藏这个属性，防止外部访问到
 */
@protocol WBListActionToControllerProtocol;
@class WBCollectionUpdater;

@interface WBCollectionViewAdapter ()

@property (nonatomic, weak) id<WBListActionToControllerProtocol> actionDelegate;

@property (nonatomic, weak, readwrite) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL isInDifferring;
@property (nonatomic, strong) NSMutableArray *oldSections; // used for diff
@property (nonatomic, strong) WBCollectionUpdater *updater;
@property (nonatomic, strong) NSMutableArray *sections;

/**
 重置所有section和row的记录，同步old和new
 */
- (void)resetAllSectionsAndRowsRecords;

@end
