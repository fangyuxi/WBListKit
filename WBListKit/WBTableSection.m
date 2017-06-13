//
//  WBListSection.m
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import "WBTableSection.h"

@interface WBTableSection ()

/**
 存放此section关联的row 类型为WBListRow
 */
@property (nonatomic, strong) NSMutableArray *rows;

@end

@implementation WBTableSection

@synthesize rowCount = _rowCount;

- (instancetype)init{
    self = [super init];
    [self setIdentifier:[NSString stringWithFormat:@"%lu",(unsigned long)[self hash]]];
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

- (void)setMaker:(WBTableSectionMaker * _Nullable)maker{
    _maker = maker;
}

- (void)setIdentifier:(NSString * _Nonnull)identifier{
    _identifier = identifier;
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
    return self.identifier;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBTableSection *section = (WBTableSection *)object;
    return [self.identifier isEqualToString:section.identifier];
}

@end
