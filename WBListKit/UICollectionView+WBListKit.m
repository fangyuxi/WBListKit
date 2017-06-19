//
//  UITableView+WBListKit.m
//  Pods
//
//  Created by Romeo on 2017/5/15.
//
//

#import "UICollectionView+WBListKit.h"
#import "UICollectionView+WBListKitPrivate.h"
#import <objc/runtime.h>
#import "WBListReusableViewProtocol.h"
#import "WBCollectionViewAdapterPrivate.h"
#import "WBCollectionViewDataSourcePrivate.h"

static int AdapterKey;
static int DataSourceKey;
static int WBListActionToControllerProtocolKey;

@implementation UICollectionView (WBListKit)

- (void)setActionDelegate:(id<WBListActionToControllerProtocol>)actionDelegate{
    objc_setAssociatedObject(self, &WBListActionToControllerProtocolKey, actionDelegate, OBJC_ASSOCIATION_ASSIGN);
    self.adapter.actionDelegate = actionDelegate;
}

- (id<WBListActionToControllerProtocol>)actionDelegate{
    return objc_getAssociatedObject(self, &WBListActionToControllerProtocolKey);
}

- (void)setAdapter:(WBCollectionViewAdapter *)adapter{
    objc_setAssociatedObject(self, &AdapterKey, adapter, OBJC_ASSOCIATION_ASSIGN);
    adapter.collectionView = self;
    adapter.actionDelegate = self.actionDelegate;
}

- (WBCollectionViewAdapter *)adapter{
    return objc_getAssociatedObject(self, &AdapterKey);
}

- (void)setCollectionViewDataSource:(id<UICollectionViewDataSource>)collectionViewDataSource{
    objc_setAssociatedObject(self, &DataSourceKey, collectionViewDataSource, OBJC_ASSOCIATION_ASSIGN);
    self.adapter.collectionViewDataSource = collectionViewDataSource;
}

- (id<UICollectionViewDataSource>)collectionViewDataSource{
    return objc_getAssociatedObject(self, &DataSourceKey);
}

- (void)willAppear{
    [self.adapter willAppear];
}

- (void)didDisappear{
    [self.adapter didDisappear];
}

- (void)bindViewDataSource:(nonnull WBCollectionViewDataSource *)source{
    [self unbindViewDataSource];
    [source bindCollectionView:self];
    [self reloadData];
}

- (void)unbindViewDataSource{
    [self.source unBindCollectionView];
}

- (void)beginAutoDiffer{
    [self.adapter beginAutoDiffer];
}
- (void)commitAutoDifferWithAnimation:(BOOL)animation{
    [self.adapter commitAutoDifferWithAnimation:animation];
}
- (void)reloadDifferWithAnimation:(BOOL)animation{
    [self.adapter reloadDifferWithAnimation:animation];
}

@end
