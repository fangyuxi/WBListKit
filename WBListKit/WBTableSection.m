//
//  WBListSection.m
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import "WBTableSection.h"
#import "WBTableSectionPrivate.h"
#import "WBTableHeaderFooterViewProtocal.h"
#import "_WBTableSectionDefaultPlaceholderHeaderFooterView.h"

@implementation WBTableSection

- (instancetype)init{
    self = [super init];
    self.oldArray = [NSMutableArray array];
    [self setKey:[NSString stringWithFormat:@"%lu",(unsigned long)[self hash]]];
    return self;
}

/**
 gets
 */
- (nullable WBTableRow *)rowAtIndex:(NSInteger)index{
    if (index < self.rowCount){
        return self.rows[(NSUInteger) index];
    }
    return nil;
}

- (nullable WBTableRow *)rowForKey:(NSString *)key{
    __block WBTableRow *row = nil;
    [self.rows enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WBTableRow *tmpRow = (WBTableRow *)obj;
        if ([tmpRow.key isEqualToString:key]){
            row = tmpRow;
            BOOL b = true;
            stop = &b;
        }
    }];
    if (!row) {
        return nil;
    }
    return row;
}

/**
 inserts
 */
- (void)addRow:(WBTableRow *)row{
    [self insertRow:row atIndex:self.rowCount];
}
- (void)addRows:(NSArray<WBTableRow *> *)rows{
    if (rows) {
        [self.rows addObjectsFromArray:rows];
    }
}
- (void)insertRow:(WBTableRow *)row
          atIndex:(NSUInteger)index{
    if (row && index <= self.rows.count){
        [self.rows insertObject:row atIndex:index];
    }
}

- (void)addNewRow:(void(^)(WBTableRow *row))block{
    WBTableRow *row = [WBTableRow new];
    [self addRow:row];
    block(row);
}

/**
 delete
 */
- (void)deleteRow:(WBTableRow *)row{
    [self.rows removeObject:row];
}
- (void)deleteRowAtIndex:(NSUInteger)index{
    if (index < self.rows.count){
        [self.rows removeObjectAtIndex:index];
    }
}
- (void)deleteAllRows{
    [self.rows removeAllObjects];
}

/**
 exchange replace
 */
- (void)replaceRowAtIndex:(NSUInteger)index
                  withRow:(WBTableRow *)row{
    if (row){
        self.rows[index] = row;
    }
}
- (void)exchangeRowAtIndex:(NSUInteger)index1
                 withIndex:(NSInteger)index2{
    if (index1 < self.rows.count && index2 < self.rows.count){
        [self.rows exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    }
}

#pragma mark getter

- (NSMutableArray *)rows{
    if (!_rows){
        _rows = [NSMutableArray<WBTableRow *> array];
    }
    return _rows;
}

- (NSUInteger)rowCount{
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

- (void)setHeader:(WBTableSectionHeaderFooter *)header {
    _header = header;
    _headerHeight = header.calculateHeight(header);
}

- (void)setFooter:(WBTableSectionHeaderFooter *)footer {
    _footer = footer;
    _footerHeight = footer.calculateHeight(footer);
}

#pragma mark differ protocol

- (nonnull id<NSObject>)diffIdentifier{
    return [NSString stringWithFormat:@"%lu",(unsigned long)[self hash]];
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBTableSection *section = (WBTableSection *)object;
    return [self hash] == [section hash];
}

#pragma mark private

- (void)recordOldArray{
    self.oldArray = [self.rows copy];
}

- (void)resetOldArray{
    self.oldArray = [self.rows copy];
}

#pragma mark default header footer

- (void)setHeaderColor:(UIColor *)headerColor {
    _headerColor = headerColor;
    [self createDefaultHeaderViewIfNeeded];
}

- (void)setHeaderHeight:(CGFloat)headerHeight {
    _headerHeight = headerHeight;
    [self createDefaultHeaderViewIfNeeded];
}

- (void)setFooterColor:(UIColor *)footerColor {
    _footerColor = footerColor;
    [self createDefaultFooterViewIfNeeded];
}

- (void)setFooterHeight:(CGFloat)footerHeight {
    _footerHeight = footerHeight;
    [self createDefaultFooterViewIfNeeded];
}

- (void)createDefaultHeaderViewIfNeeded{
    if (!self.header){
        WBTableSectionHeaderFooter *header = [WBTableSectionHeaderFooter new];
        header.displayType = WBTableHeaderFooterTypeHeader;
        header.associatedHeaderFooterClass = [_WBTableSectionDefaultPlaceholderHeaderFooterView class];
        self.header = header;
    }
}

- (void)createDefaultFooterViewIfNeeded{
    if (!self.footer){
        WBTableSectionHeaderFooter *footer = [WBTableSectionHeaderFooter new];
        footer.displayType = WBTableHeaderFooterTypeFooter;
        footer.associatedHeaderFooterClass = [_WBTableSectionDefaultPlaceholderHeaderFooterView class];
        self.footer = footer;
    }
}

- (void)updateRowPosition {
    
    NSUInteger rowCount = self.rows.count;
    if (0 == rowCount) {
        return;
    }
    if (1 == rowCount) {
        WBTableRow *row = [self.rows firstObject];
        row.position = WBTableRowPositionSingle;
        return;
    }
    for (NSUInteger i = 0; i < rowCount; i ++) {
        WBTableRow *row = self.rows[i];
        if (0 == i) {
            row.position = WBTableRowPositionTop;
            continue;
        }
        if (rowCount - 1 == i) {
            row.position = WBTableRowPositionBottom;
            continue;
        }
        row.position = WBTableRowPositionMiddle;
    }
}

@end
