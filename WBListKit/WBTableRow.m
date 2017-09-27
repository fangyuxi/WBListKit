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
    
    self.reloadKeyGenerator = ^NSString *(__weak WBTableRow *row) {
        return [NSString stringWithFormat:@"%lu",(unsigned long)[row hash]];
    };

    return self;
}

- (void)setAssociatedCellClass:(Class)associatedCellClass{
    NSString *className = NSStringFromClass(associatedCellClass);
    WBListKitAssert([className hasSuffix:@"Cell"], [[NSString alloc] initWithFormat:@"cell的名字必须以Cell结尾"]);
    _associatedCellClass = associatedCellClass;
}

#pragma mark differ protocol

- (nonnull id<NSObject>)diffIdentifier{
    return self.reloadKeyGenerator(self);
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBTableRow *row = (WBTableRow *)object;
    NSString *string1 = self.reloadKeyGenerator(self);
    NSString *string2 = row.reloadKeyGenerator(row);
    return [string1 isEqualToString:string2];
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
    newRow.reloadKeyGenerator = [self.reloadKeyGenerator copy];
    return newRow;
}

@end
