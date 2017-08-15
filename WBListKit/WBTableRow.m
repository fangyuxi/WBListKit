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
    [self setKey:[NSString stringWithFormat:@"%lu",(unsigned long)[self hash]]];
    return self;
}

- (void)setAssociatedCellClass:(Class)associatedCellClass
{
    NSString *className = NSStringFromClass(associatedCellClass);
    WBListKitAssert([className hasSuffix:@"Cell"], [[NSString alloc] initWithFormat:@"Cell Class Name Must end with 'Cell' "]);
    _associatedCellClass = associatedCellClass;
}

#pragma mark differ protocol

- (nonnull id<NSObject>)diffIdentifier{
    return self.key;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBTableRow *row = (WBTableRow *)object;
    return [self.key isEqualToString:row.key];
}

@end
