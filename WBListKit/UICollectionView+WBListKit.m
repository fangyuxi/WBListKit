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

static int WBListActionToControllerProtocolKey;

@implementation UICollectionView (WBListKit)

- (void)setActionDelegate:(id<WBListActionToControllerProtocol>)actionDelegate{
    objc_setAssociatedObject(self, &WBListActionToControllerProtocolKey, actionDelegate, OBJC_ASSOCIATION_ASSIGN);
    self.adapter.actionDelegate = actionDelegate;
}

- (id<WBListActionToControllerProtocol>)actionDelegate{
    return objc_getAssociatedObject(self, &WBListActionToControllerProtocolKey);
}

- (void)bindAdapter:(nonnull WBCollectionViewAdapter *)adapter{
    [adapter bindCollectionView:self];
}

- (void)unbindAdapter{
    [self.adapter unBindCollectionView];
}

- (void)bindViewDataSource:(nonnull WBCollectionViewDataSource *)source{
    [source bindCollectionView:self];
}

- (void)unbindViewDataSource{
    [self.source unBindCollectionView];
}


@end
