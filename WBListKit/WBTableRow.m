//
//  WBListRow.m
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import "WBTableRow.h"

const CGFloat WBListCellHeightAutoLayout = -1.0f;

@implementation WBTableRow

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

- (void)setAssociatedCellClass:(Class)associatedCellClass{
    NSString *className = NSStringFromClass(associatedCellClass);
    WBListKitAssert([className hasSuffix:@"Cell"], [[NSString alloc] initWithFormat:@"cell的名字必须以Cell结尾"]);
    _associatedCellClass = associatedCellClass;
}

#pragma mark differ protocol

- (nonnull id<NSObject>)diffIdentifier{
    return [NSString stringWithFormat:@"%lu",(unsigned long)[self hash]];
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBTableRow *row = (WBTableRow *)object;
    return [self hash] == [row hash];
}

#pragma mark copy

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

- (CGFloat)height {
    return self.calculateHeight(self);
}

@end
