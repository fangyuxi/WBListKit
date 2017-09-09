//
//  WBCollectionItem.m
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import "WBCollectionItem.h"

@implementation WBCollectionItem

- (instancetype)init{
    self = [super init];
    [self setReloadKey:[NSString stringWithFormat:@"%lu",(unsigned long)[self hash]]];
    return self;
}

- (void)setKey:(NSString *)key{
    if (!key) {
        _key = [NSString stringWithFormat:@"%lu",(unsigned long)[self hash]];
        return;
    }
    _key = key;
}

- (void)setAssociatedCellClass:(Class)associatedCellClass
{
    NSString *className = NSStringFromClass(associatedCellClass);
    WBListKitAssert([className hasSuffix:@"Cell"], [[NSString alloc] initWithFormat:@"Cell Class Name Must end with 'Cell' "]);
    _associatedCellClass = associatedCellClass;
}

#pragma mark differ protocol

- (nonnull id<NSObject>)diffIdentifier{
    return self.reloadKey;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBCollectionItem *row = (WBCollectionItem *)object;
    return [self.reloadKey isEqualToString:row.reloadKey];
}

#pragma mark copy

- (id)copyWithZone:(NSZone *)zone{
    WBCollectionItem *newItem = [[[self class] alloc] init];
    newItem.data = self.data;
    newItem.key = self.key;
    newItem.associatedCellClass = self.associatedCellClass;
    newItem.indexPath = self.indexPath;
    newItem.reloadKey = [[NSString alloc] initWithString:self.reloadKey];
    return newItem;
}
@end
