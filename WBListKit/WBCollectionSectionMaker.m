//
//  WBCollectionSectionMaker.m
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import "WBCollectionSectionMaker.h"

@interface WBCollectionSectionMaker ()

@property (nonatomic, strong, readwrite) WBCollectionSection *section;

@end

@implementation WBCollectionSectionMaker

- (instancetype)initWithSection:(WBCollectionSection *)section
{
    if (!section) {
        return nil;
    }
    
    self = [super init];
    self.section = section;
    return self;
}

/**
 链式语法的连词
 
 @return self
 */
- (WBCollectionSectionMaker *)and{
    return self;
}


/**
 row count
 
 @return 'count'
 */
- (NSUInteger)itemsCount{
    return self.section.itemCount;
}

/**
 *  设置section的唯一标识符
 *
 */
- (WBCollectionSectionMaker *(^)(NSString *identifier))setIdentifier{
    
    return ^(NSString *identifier){
        self.section.identifier = identifier;
        return self;
    };
}

/**
 *  返回一行
 */
- (WBCollectionItem *(^)(NSUInteger index))itemAtIndex{
    
    return ^WBCollectionItem *(NSUInteger index){
        
        WBCollectionItem *row = [self.section itemAtIndex:index];
        return row;
    };
}

/**
 *  追加一行 返回该行的RowMaker
 */
- (WBCollectionSectionMaker *(^)(WBCollectionItem *row))addItem{
    
    return ^WBCollectionSectionMaker *(WBCollectionItem *item){
        
        [self.section addItem:item];
        return self;
    };
}

/**
 *  在指定位置插入一行 返回该行的RowMaker
 */
- (WBCollectionSectionMaker *(^)(WBCollectionItem *item, NSUInteger index))insertItem{
    
    return ^WBCollectionSectionMaker *(WBCollectionItem *item, NSUInteger index){
        
        [self.section insertItem:item atIndex:index];
        return self;
    };
}

/**
 *  追加多行
 */
- (WBCollectionSectionMaker *(^)(NSArray *items))addItems{
    
    return ^WBCollectionSectionMaker *(NSArray *items){
        
        [self.section addItems:items];
        return self;
    };
}

/**
 *  替换一行 返回新的一行的RowMaker
 */
- (WBCollectionSectionMaker *(^)(WBCollectionItem *item, NSUInteger index))replaceItem{
    
    return ^WBCollectionSectionMaker *(WBCollectionItem *item, NSUInteger index){
        
        [self.section replaceItemAtIndex:index withItem:item];
        return self;
    };
}

/**
 *  交换两行
 */
- (WBCollectionSectionMaker *(^)(NSUInteger idx1, NSUInteger idx2))exchangeItem{
    
    return ^WBCollectionSectionMaker *(NSUInteger idx1, NSUInteger idx2){
        
        [self.section exchangeItemAtIndex:idx1 withIndex:idx2];
        return self;
    };
}

/**
 *  删除操作
 */
- (WBCollectionSectionMaker *(^)(NSUInteger index))deleteItemAtIndex{
    
    return ^WBCollectionSectionMaker *(NSUInteger index){
        
        [self.section deleteItemAtIndex:index];
        return self;
    };
    
}
- (WBCollectionSectionMaker *(^)(WBCollectionItem *item))deleteItem{
    
    return ^WBCollectionSectionMaker *(WBCollectionItem *item){
        WBListKitAssert(item, @"要删除的Row未空");
        [self.section deleteItem:item];
        return self;
    };
}
- (WBCollectionSectionMaker *(^)())deleteAllItems{
    
    return ^WBCollectionSectionMaker *(){
        
        [self.section deleteAllItems];
        return self;
    };
}
@end
