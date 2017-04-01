//
//  WBListSectionMaker.m
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import "WBTableSectionMaker.h"

@interface WBTableSectionMaker ()

@property (nonatomic, weak, readwrite) WBTableSection *section;

@end

@implementation WBTableSectionMaker

- (instancetype)initWithSection:(WBTableSection *)section
{
    if (!section) {
        return nil;
    }
    
    self = [super init];
    self.animationType = UITableViewRowAnimationTop;
    self.animationUpdate = YES;
    self.section = section;
    return self;
}

/**
 链式语法的连词
 
 @return self
 */
- (WBTableSectionMaker *)and
{
    return self;
}

- (NSUInteger)rowCount{
    return self.section.rowCount;
}

/**
 *  设置section的唯一标识符
 *
 */
- (WBTableSectionMaker *(^)(NSString *identifier))setIdentifier{
    
    return ^WBTableSectionMaker *(NSString *identifier){
        
        self.section.identifier = identifier;
        return self;
    };
}

/**
 *  返回一行
 */
- (WBTableRow *(^)(NSUInteger index))rowAtIndex{
    
    return ^WBTableRow *(NSUInteger index){
        
        WBTableRow *row = [self.section rowAtIndex:index];
        return row;
    };
}

/**
 *  追加一行 返回该行的RowMaker
 */
- (WBTableSectionMaker *(^)(WBTableRow *row))addRow{
    
    return ^WBTableSectionMaker *(WBTableRow *row){
        
        [self.section addRow:row];
        return self;
    };
}

/**
 *  在指定位置插入一行 返回该行的RowMaker
 */
- (WBTableSectionMaker *(^)(WBTableRow *row, NSUInteger index))insertRow{
    
    return ^WBTableSectionMaker *(WBTableRow *row, NSUInteger index){
        
        [self.section insertRow:row atIndex:index];
        return self;
    };
}

/**
 *  追加多行
 */
- (WBTableSectionMaker *(^)(NSArray *rows))addRows{
    
    return ^WBTableSectionMaker *(NSArray *rows){
        
        [self.section addRows:rows];
        return self;
    };
}

/**
 *  替换一行 返回新的一行的RowMaker
 */
- (WBTableSectionMaker *(^)(WBTableRow *row, NSUInteger index))replaceRow{
    
    return ^WBTableSectionMaker *(WBTableRow *row, NSUInteger index){
        
        [self.section replaceRowAtIndex:index withRow:row];
        return self;
    };
}

/**
 *  交换两行
 */
- (WBTableSectionMaker *(^)(NSUInteger idx1, NSUInteger idx2))exchangeRow{
    
    return ^WBTableSectionMaker *(NSUInteger idx1, NSUInteger idx2){
        
        [self.section exchangeRowAtIndex:idx1 withIndex:idx2];
        return self;
    };
}

/**
 *  删除操作
 */
- (WBTableSectionMaker *(^)(NSUInteger index))deleteRowAtIndex{
    
    return ^WBTableSectionMaker *(NSUInteger index){
        
        [self.section deleteRowAtIndex:index];
        return self;
    };
    
}
- (WBTableSectionMaker *(^)(WBTableRow *row))deleteRow{
    
    return ^WBTableSectionMaker *(WBTableRow *row){
        WBListKitAssert(row, @"要删除的Row未空");
        [self.section deleteRow:row];
        return self;
    };
    
}
- (WBTableSectionMaker *(^)())deleteAllRows
{
    return ^WBTableSectionMaker *(){
      
        [self.section deleteAllRows];
        return self;
    };
}

- (WBTableSectionMaker *(^)(WBTableSectionHeaderFooter *header))addHeader{
    return ^WBTableSectionMaker *(WBTableSectionHeaderFooter *header){
        WBListKitAssert(header, @"添加的Header为空");
        header.displayType = WBTableHeaderFooterTypeHeader;
        self.section.header = header;
        return self;
    };
    
}
- (WBTableSectionMaker *(^)(WBTableSectionHeaderFooter *footer))addFooter{
    
    return ^WBTableSectionMaker *(WBTableSectionHeaderFooter *footer){
        WBListKitAssert(footer, @"添加的Footer为空");
        footer.displayType = WBTableHeaderFooterTypeFooter;
        self.section.footer = footer;
        return self;
    };
}

@end
