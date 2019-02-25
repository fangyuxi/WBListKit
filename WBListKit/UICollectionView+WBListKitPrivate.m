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
#import "WBCollectionSectionPrivate.h"
#import "WBListKitMacros.h"

static int SourceKey;

@implementation UICollectionView (WBListKitPrivate)

+ (void)load {
    SEL selectors[] = {
        @selector(reloadData),
        @selector(reloadSections:)
    };
    
    for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
        SEL originalSelector = selectors[index];
        SEL swizzledSelector = NSSelectorFromString([@"wblist_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)wblist_reloadData {
    [self.adapter resetAllSectionsAndRowsRecords];
    WBLISTPrimaryCall([self wblist_reloadData];);
}

- (void)wblist_reloadSections:(NSIndexSet *)sections {
    
    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        WBCollectionSection *sectionObject = [self.adapter sectionAtIndex:idx];
        [sectionObject resetOldArray];
    }];
    WBLISTPrimaryCall([self wblist_reloadSections:sections];);
}

- (void)setSource:(WBCollectionViewDataSource *)source{
    objc_setAssociatedObject(self, &SourceKey, source, OBJC_ASSOCIATION_ASSIGN);
}

- (WBCollectionViewDataSource *)source{
    return objc_getAssociatedObject(self, &SourceKey);
}

@end
