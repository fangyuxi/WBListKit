//
//  WBListSection.m
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import "WBTableSection.h"
#import "WBTableSectionPrivate.h"

@implementation WBTableSection

@synthesize rowCount = _rowCount;

- (instancetype)init{
    self = [super init];
    self.oldArray = [NSMutableArray array];
    [self setKey:[NSString stringWithFormat:@"%lu",(unsigned long)[self hash]]];
    return self;
}

/**
 gets
 */
- (nullable __kindof WBTableRow *)rowAtIndex:(NSUInteger)index
{
    if (index < self.rowCount)
    {
        return [self.rows objectAtIndex:index];
    }
    return nil;
}

/**
 inserts
 */
- (void)addRow:(WBTableRow *)row
{
    [self insertRow:row atIndex:self.rowCount];
}
- (void)addRows:(NSArray<WBTableRow *> *)rows
{
    if (rows) {
        [self.rows addObjectsFromArray:rows];
    }
}
- (void)insertRow:(WBTableRow *)row
          atIndex:(NSUInteger)index
{
    if (row && index <= self.rows.count)
    {
        [self.rows insertObject:row atIndex:index];
    }
}

/**
 delete
 */
- (void)deleteRow:(WBTableRow *)row
{
    [self.rows removeObject:row];
}
- (void)deleteRowAtIndex:(NSUInteger)index
{
    if (index < self.rows.count)
    {
        [self.rows removeObjectAtIndex:index];
    }
}
- (void)deleteAllRows
{
    [self.rows removeAllObjects];
}

/**
 exchange replace
 */
- (void)replaceRowAtIndex:(NSUInteger)index
                  withRow:(WBTableRow *)row
{
    if (row)
    {
        [self.rows replaceObjectAtIndex:index withObject:row];
    }
}
- (void)exchangeRowAtIndex:(NSUInteger)index1
                 withIndex:(NSInteger)index2
{
    if (index1 < self.rows.count && index2 < self.rows.count)
    {
        [self.rows exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    }
}

#pragma mark getter

- (NSMutableArray *)rows
{
    if (!_rows)
    {
        _rows = [NSMutableArray<WBTableRow *> array];
    }
    return _rows;
}

- (NSUInteger)rowCount
{
    return [self.rows count];
}

#pragma mark setter

- (void)setKey:(NSString * _Nonnull)key{
    if (!key) {
        key = [NSString stringWithFormat:@"%lu",(unsigned long)[self hash]];
        return;
    }
    _key = key;
}

- (void)setRowCount:(NSUInteger)rowCount{
    _rowCount = rowCount;
}

- (void)setHeader:(WBTableSectionHeaderFooter * _Nullable)header{
    _header = header;
}

- (void)setFooter:(WBTableSectionHeaderFooter * _Nullable)footer{
    _footer = footer;
}

#pragma mark differ protocol

- (nonnull id<NSObject>)diffIdentifier{
    return self.key;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBTableSection *section = (WBTableSection *)object;
    return [self.key isEqualToString:section.key];
}

#pragma mark private

- (void)recordOldArray{
    self.oldArray = self.rows;
}

- (void)resetOldArray{
    self.oldArray = self.rows;
}

@end
