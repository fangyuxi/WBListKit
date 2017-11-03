//
//  UITableView+WBListKitPrivate.m
//  Pods
//
//  Created by fangyuxi on 2017/5/16.
//
//

#import "UICollectionView+WBListKitPrivate.h"
#import <objc/runtime.h>
#import "UICollectionView+WBListKit.h"
#import "WBCollectionViewAdapterPrivate.h"

static int SourceKey;

@implementation UICollectionView (WBListKitPrivate)

- (void)setSource:(WBCollectionViewDataSource *)source{
    objc_setAssociatedObject(self, &SourceKey, source, OBJC_ASSOCIATION_ASSIGN);
}

- (WBCollectionViewDataSource *)source{
    return objc_getAssociatedObject(self, &SourceKey);
}

@end
