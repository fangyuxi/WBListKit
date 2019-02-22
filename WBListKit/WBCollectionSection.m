//
//  WBCollectionSection.m
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import "WBCollectionSection.h"
#import "WBCollectionSectionPrivate.h"

@implementation WBCollectionSection

@synthesize itemCount = _itemCount;

- (instancetype)init{
    self = [super init];
    self.oldArray = [NSMutableArray array];
    [self setKey:[NSString stringWithFormat:@"%lu",(unsigned long)[self hash]]];
    return self;
}

/**
 gets
 */
- (nullable WBCollectionItem *)itemAtIndex:(NSUInteger)index{
    if (index < self.itemCount){
        return [self.items objectAtIndex:index];
    }
    return nil;
}

/**
 inserts
 */
- (void)addItem:(WBCollectionItem *)item{
    [self insertItem:item atIndex:self.itemCount];
}
- (void)addItems:(NSArray<WBCollectionItem *> *)items{
    if (items){
        [self.items addObjectsFromArray:items];
    }
}
- (void)insertItem:(WBCollectionItem *)item
           atIndex:(NSUInteger)index{
    if (item && index <= self.items.count){
        [self.items insertObject:item atIndex:index];
    }
}
- (void)addNewItem:(void(^)(WBCollectionItem *item))block{
    WBCollectionItem *item = [WBCollectionItem new];
    [self addItem:item];
    block(item);
}

/**
 delete
 */
- (void)deleteItem:(WBCollectionItem *)item{
    [self.items removeObject:item];
}
- (void)deleteItemAtIndex:(NSUInteger)index{
    if (index < self.items.count){
        [self.items removeObjectAtIndex:index];
    }
}
- (void)deleteAllItems{
    [self.items removeAllObjects];
}

/**
 exchange replace
 */
- (void)replaceItemAtIndex:(NSUInteger)index
                  withItem:(WBCollectionItem *)item{
    if (item){
        [self.items replaceObjectAtIndex:index withObject:item];
    }
}
- (void)exchangeItemAtIndex:(NSUInteger)index1
                  withIndex:(NSInteger)index2{
    if (index1 < self.items.count && index2 < self.items.count){
        [self.items exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    }
    
}
#pragma mark setter

- (void)setKey:(NSString * _Nonnull)key{
    if (!key) {
        key = [NSString stringWithFormat:@"%lu",(unsigned long)[self hash]];
        return;
    }
    _key = key;
}

#pragma mark getter

- (NSMutableArray *)items{
    if (!_items){
        _items = [NSMutableArray<WBCollectionItem *> array];
    }
    return _items;
}

- (NSUInteger)itemCount{
    return [self.items count];
}

#pragma mark differ protocol

- (nonnull id<NSObject>)diffIdentifier{
    return self.key;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object{
    WBCollectionSection *section = (WBCollectionSection *)object;
    return [section.key isEqualToString:section.key];
}

#pragma mark private

- (void)recordOldArray{
    self.oldArray = [self.items copy];
}

- (void)resetOldArray{
    self.oldArray = [self.items copy];
}

@end
