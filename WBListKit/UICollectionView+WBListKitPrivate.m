//
//  UITableView+WBListKitPrivate.m
//  Pods
//
//  Created by Romeo on 2017/5/16.
//
//

#import "UICollectionView+WBListKitPrivate.h"
#import <objc/runtime.h>
#import "UICollectionView+WBListKit.h"
#import "WBCollectionViewAdapterPrivate.h"

static int AdapterKey;

@implementation UICollectionView (WBListKitPrivate)

- (void)setAdapter:(WBCollectionViewAdapter *)adapter{
    objc_setAssociatedObject(self, &AdapterKey, adapter, OBJC_ASSOCIATION_ASSIGN);
    adapter.actionDelegate = self.actionDelegate;
}

- (WBCollectionViewAdapter *)adapter{
   return objc_getAssociatedObject(self, &AdapterKey);
}

@end
