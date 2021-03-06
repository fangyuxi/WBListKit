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
    _key = [NSString stringWithFormat:@"%lu",(unsigned long)[self hash]];
    return self;
}

- (void)setKey:(NSString *)key{
    if (!key) {
        _key = [NSString stringWithFormat:@"%lu",(unsigned long)[self hash]];
        return;
    }
    _key = [key copy];
}

- (void)setAssociatedCellClass:(Class)associatedCellClass
{
    NSString *className = NSStringFromClass(associatedCellClass);
    WBListKitAssert([className hasSuffix:@"Cell"], [[NSString alloc] initWithFormat:@"Cell Class Name Must end with 'Cell' "]);
    _associatedCellClass = associatedCellClass;
}

#pragma mark differ protocol

- (nonnull id<NSObject>)diffIdentifier{
    return [NSString stringWithFormat:@"%lu",(unsigned long)[self hash]];
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBCollectionItem *item = (WBCollectionItem *)object;
    return [self hash] == [item hash];
}

#pragma mark copy

- (id)copyWithZone:(NSZone *)zone{
    return self;
}
@end
