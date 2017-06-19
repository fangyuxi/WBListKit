//
//  WBCollectionViewAdapterPrivate.h
//  Pods
//
//  Created by Romeo on 2017/5/16.
//
//

/**
 隐藏，防止外部访问到
 */
@protocol WBListActionToControllerProtocol;
@class WBCollectionUpdater;

@interface WBCollectionViewAdapter ()

@property (nonatomic, weak) id<WBListActionToControllerProtocol> actionDelegate;
@property (nonatomic, weak) id<UICollectionViewDataSource> collectionViewDataSource;
@property (nonatomic, weak, readwrite) UICollectionView *collectionView;

- (void)willAppear;
- (void)didDisappear;

@property (nonatomic, assign) BOOL isInDifferring;
@property (nonatomic, strong) NSMutableArray *oldSections;
@property (nonatomic, strong) WBCollectionUpdater *updater;
@property (nonatomic, strong) NSMutableArray *sections;

- (void)resetAllSectionsAndRowsRecords;

@end
