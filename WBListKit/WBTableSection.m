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
- (nullable __kindof WBTableRow *)rowAtIndex:(NSInteger)index{
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
    self.oldArray = [[NSArray alloc] initWithArray:self.rows copyItems:YES];
}

- (void)resetOldArray{
    self.oldArray =  [[NSArray alloc] initWithArray:self.rows copyItems:YES];
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

@end
