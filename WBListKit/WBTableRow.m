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
    [self setReloadKey:[NSString stringWithFormat:@"%lu",(unsigned long)[self hash]]];
    return self;
}

- (void)setAssociatedCellClass:(Class)associatedCellClass{
    NSString *className = NSStringFromClass(associatedCellClass);
    WBListKitAssert([className hasSuffix:@"Cell"], [[NSString alloc] initWithFormat:@"cell的名字必须以Cell结尾"]);
    _associatedCellClass = associatedCellClass;
}

#pragma mark differ protocol

- (nonnull id<NSObject>)diffIdentifier{
    return self.reloadKey;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBTableRow *row = (WBTableRow *)object;
    return [self.reloadKey isEqualToString:row.reloadKey];
}

#pragma mark copy

- (id)copyWithZone:(NSZone *)zone{
    WBTableRow *newRow = [[[self class] alloc] init];
    newRow.data = self.data;
    newRow.key = self.key;
    newRow.associatedCellClass = self.associatedCellClass;
    newRow.indexPath = self.indexPath;
    newRow.calculateHeight = self.calculateHeight;
    newRow.position = self.position;
    newRow.reloadKey = [[NSString alloc] initWithString:self.reloadKey];
    return newRow;
}

@end
