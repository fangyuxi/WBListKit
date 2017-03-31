//
//  WBCollectionItem.m
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import "WBCollectionItem.h"

@implementation WBCollectionItem

- (void)setAssociatedCellClass:(Class)associatedCellClass
{
    NSString *className = NSStringFromClass(associatedCellClass);
    WBListKitAssert([className hasSuffix:@"Cell"], [[NSString alloc] initWithFormat:@"Cell Class Name Must end with 'Cell' "]);
    _associatedCellClass = associatedCellClass;
}

@end
