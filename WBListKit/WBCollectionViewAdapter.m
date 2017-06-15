//
//  WBCollectionViewAdapter.m
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import "WBCollectionViewAdapter.h"
#import "WBCollectionViewDelegateProxy.h"
#import "WBCollectionCellProtocol.h"
#import "WBCollectionSupplementaryViewProtocol.h"
#import "WBCollectionSectionPrivate.h"
#import "WBCollectionViewAdapterPrivate.h"
#import "WBCollectionItem.h"
#import "WBCollectionSection.h"
#import "WBCollectionSectionPrivate.h"

#ifndef StringForIndexPath
#define StringForIndexPath(v) [NSString stringWithFormat:@"%ld-,%ld", (long)v.item, (long)v.section]
#endif

@interface WBCollectionViewAdapter ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak, readwrite) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableDictionary *supplementaryItems;

@property (nonatomic, strong) NSMutableSet *registedCellIdentifiers;
@property (nonatomic, strong) NSMutableSet *registedSupplementaryIdentifiers;

@property (nonatomic, strong) WBCollectionViewDelegateProxy *delegateProxy;
@end

@implementation WBCollectionViewAdapter

- (void)bindCollectionView:(UICollectionView *)collectionView{
    NSCAssert([collectionView isKindOfClass:[UICollectionView class]], @"bindCollectionView 需要一个 UICollectinView实例");
    [self unBindCollectionView];
    self.collectionView = collectionView;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    if (self.actionDelegate || self.collectionViewDataSource) {
        [self updateCollectionDelegateProxy];
    }
}

- (void)unBindCollectionView{
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
    self.collectionView = nil;
}

#pragma mark manage appearance

- (void)willAppear{
    NSArray *cells = [self.collectionView visibleCells];
    
    [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UITableViewCell<WBCollectionCellProtocol> *cell = obj;
        if ([cell respondsToSelector:@selector(reload)]) {
            [cell reload];
        }
    }];
    
    //TODO invoke SupplementaryViews 'reload'
}

- (void)didDisappear{
    NSArray *cells = [self.collectionView visibleCells];
    
    [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UITableViewCell<WBCollectionCellProtocol> *cell = obj;
        if ([cell respondsToSelector:@selector(cancel)]) {
            [cell cancel];
        }
    }];
    
    //TODO invoke SupplementaryViews 'cancel'
}

#pragma mark section operators

- (WBCollectionSection *)sectionAtIndex:(NSUInteger)index{
    if (index >= self.sections.count){
        return nil;
    }
    WBCollectionSection *section = [self.sections objectAtIndex:index];
    return section;
}

- (WBCollectionSection *)sectionForKey:(NSString *)identifier{
    
    __block WBCollectionSection *section = nil;
    [self.sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WBCollectionSection *tmpSection = (WBCollectionSection *)obj;
        if ([tmpSection.key isEqualToString:identifier]){
            section = tmpSection;
            BOOL b = true;
            stop = &b;
        }
    }];
    return section;
}

- (NSUInteger)indexOfSection:(WBCollectionSection *)section{
    return [self.sections indexOfObject:section];
}

- (void)addSection:(void(^)(WBCollectionSection *newSection))block{
    [self insertSection:block atIndex:[self.sections count]];
}

- (void)insertSection:(void(^)(WBCollectionSection *newSection))block
              atIndex:(NSUInteger)index{
    if (index > self.sections.count){
        return;
    }
    WBCollectionSection *section = [[WBCollectionSection alloc] init];
    [self.sections insertObject:section atIndex:index];
    block(section);
}

- (void)updateSection:(WBCollectionSection *)section
             userBlock:(void(^)(WBCollectionSection *section))block{
    block(section);
}

- (void)updateSectionAtIndex:(NSUInteger)index
                    userBlock:(void(^)(WBCollectionSection *section))block{
    WBCollectionSection *section = [self sectionAtIndex:index];
    if (section) {
        [self updateSection:section userBlock:^(WBCollectionSection * _Nonnull section) {
            block(section);
        }];
    }
}

- (void)updateSectionForIdentifier:(NSString *)key
                         userBlock:(void(^)(WBCollectionSection *section))block{
    WBCollectionSection *section = [self sectionForKey:key];
    if (section) {
        [self updateSection:section userBlock:^(WBCollectionSection * _Nonnull section) {
            block(section);
        }];
    }
}

- (void)deleteSection:(WBCollectionSection *)section{
    [self.sections removeObject:section];
}
- (void)deleteSectionAtIndex:(NSUInteger)index{
    WBCollectionSection *section = [self sectionAtIndex:index];
    if (section) {
        [self deleteSection:section];
    }
}
- (void)deleteSectionForKey:(NSString *)key{
    WBCollectionSection *section = [self sectionForKey:key];
    if (section) {
        [self deleteSection:section];
    }
}
- (void)deleteAllSections{
    [self.sections removeAllObjects];
}

- (void)addSupplementaryItem:(WBCollectionSupplementaryItem *)item
                   indexPath:(NSIndexPath *)indexPath{
    WBListKitParameterAssert(item);
    WBListKitParameterAssert(indexPath);
    [self.supplementaryItems setObject:item forKey:StringForIndexPath(indexPath)];
}

- (void)deleteSubpplementaryItemAtIndex:(NSIndexPath *)indexPath{
    WBListKitParameterAssert(indexPath);
    [self.supplementaryItems removeObjectForKey:StringForIndexPath(indexPath)];
}

- (WBCollectionSupplementaryItem *)supplementaryItemAtIndexPath:(NSIndexPath *)indexPath{
    WBListKitParameterAssert(indexPath);
    return [self.supplementaryItems objectForKey:StringForIndexPath(indexPath)];
}

- (NSArray<NSIndexPath *> *)indexPathsForSupplementaryViews{
    NSArray *indexPathStrings = [self.supplementaryItems allKeys];
    NSMutableArray *indexPaths = [NSMutableArray array];
    [indexPathStrings enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSString *string = obj;
        NSArray *subStrings = [string componentsSeparatedByString:@"-"];
        if (subStrings.count == 2) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[subStrings[0] integerValue] inSection:[subStrings[1] integerValue]];
            [indexPaths addObject:indexPath];
        }
    }];
    return indexPaths;
}

- (void)deleteAllElements{
    [self deleteAllSections];
    self.supplementaryItems = nil;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    WBListKitAssertMainThread();
    if ([self.collectionViewDataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        return [self.collectionViewDataSource numberOfSectionsInCollectionView:collectionView];
    }
    return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    WBListKitAssertMainThread();
    if ([self.collectionViewDataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        return [self.collectionViewDataSource collectionView:collectionView numberOfItemsInSection:section];
    }
    WBCollectionSection *sectionObject = [self sectionAtIndex:section];
    return sectionObject.itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WBListKitAssertMainThread();
    WBCollectionSection *section = [self sectionAtIndex:indexPath.section];
    WBCollectionItem *item = [section itemAtIndex:indexPath.item];
    Class cellClass = item.associatedCellClass;
    NSString *identifier = NSStringFromClass(cellClass);
    WBListKitAssert(!identifier || ![identifier isEqualToString:@""], @"item's associatedCellClass is nil");
    
    //registe if needed
    [self registeCellIfNeededUseCellClass:cellClass];
    
    // hook by
    UICollectionViewCell<WBCollectionCellProtocol> *cell = nil;
    if ([self.collectionViewDataSource respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
        cell = [self.collectionViewDataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }else{
        cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    }

    WBListKitAssert([cell conformsToProtocol:@protocol(WBCollectionCellProtocol)],@"cell 必须遵守 WBCollectionCellProtocol 协议");
    if ([cell respondsToSelector:@selector(reset)]) {
        [cell reset];
    }
    item.indexPath = indexPath;
    cell.item = item;
    if ([cell respondsToSelector:@selector(setActionDelegate:)]) {
        cell.actionDelegate = self.actionDelegate;
    }
    [cell update];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    WBListKitAssertMainThread();
    WBCollectionSupplementaryItem *item = [self.supplementaryItems objectForKey:StringForIndexPath(indexPath)];
    WBListKitAssert(item,@"can't match indexpaths in 'viewForSupplementaryElementOfKind' and 'layout object' for supplementaryview");
    Class viewClass = item.associatedViewClass;
    WBListKitAssert(viewClass,@"WBCollectionSupplementaryItem must have a associatedViewClass");
    NSString *identifier = NSStringFromClass(viewClass);
    WBListKitAssert(item.elementKind,@"WBCollectionSupplementaryItem must have a elementKind");
    
    //registe if needed
    [self registeSupplementaryViewIfNeededUseClass:viewClass kind:item.elementKind];
    
    //hook by
    UICollectionReusableView<WBCollectionSupplementaryViewProtocol> *view = nil;
    if ([self.collectionViewDataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        view = (UICollectionReusableView<WBCollectionSupplementaryViewProtocol> *)[self.collectionViewDataSource collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }else{
        view = [self.collectionView dequeueReusableSupplementaryViewOfKind:item.elementKind
                                                       withReuseIdentifier:identifier
                                                              forIndexPath:indexPath];
    }
    WBListKitAssert([view isKindOfClass:[UICollectionReusableView class]],@"SupplementaryView 必须是 UICollectionReusableView的子类");
    WBListKitAssert([view conformsToProtocol:@protocol(WBCollectionSupplementaryViewProtocol)],@"SupplementaryView 必须遵守 WBCollectionSupplementaryViewProtocol 协议");
    if ([view respondsToSelector:@selector(reset)]) {
        [view reset];
    }
    item.indexPath = indexPath;
    view.item = item;
    if ([view respondsToSelector:@selector(setActionDelegate:)]) {
        view.actionDelegate = self.actionDelegate;
    }
    [view update];
    return view;
}


#pragma mark setters

- (void)setCollectionViewDataSource:(id)collectionViewDataSource {
    if (_collectionViewDataSource != collectionViewDataSource) {
        _collectionViewDataSource = collectionViewDataSource;
        [self updateCollectionDelegateProxy];
    }
}

- (void)setActionDelegate:(id<WBListActionToControllerProtocol>)actionDelegate{
    if (_actionDelegate != actionDelegate) {
        _actionDelegate = actionDelegate;
        [self updateCollectionDelegateProxy];
    }
}

#pragma mark getters

- (NSMutableSet *)registedCellIdentifier
{
    if (!_registedCellIdentifiers) {
        _registedCellIdentifiers = [NSMutableSet set];
    }
    return _registedCellIdentifiers;
}

- (NSMutableSet *)registedSupplementaryIdentifiers
{
    if (!_registedSupplementaryIdentifiers) {
        _registedSupplementaryIdentifiers = [NSMutableSet set];
    }
    return _registedSupplementaryIdentifiers;
}

- (NSMutableArray *)sections
{
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

- (NSMutableDictionary *)supplementaryItems{
    if (!_supplementaryItems) {
        _supplementaryItems = [NSMutableDictionary dictionary];
    }
    return _supplementaryItems;
}


#pragma mark private method

- (void)updateCollectionDelegateProxy{
    
    // there is a known bug with accessibility and using an NSProxy as the delegate that will cause EXC_BAD_ACCESS
    // when voiceover is enabled. it will hold an unsafe ref to the delegate
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    
    self.delegateProxy = [[WBCollectionViewDelegateProxy alloc] initWithCollectionViewDataSourceTarget:_collectionViewDataSource collectionViewDelegateTarget:_actionDelegate interceptor:self];
    
    // set up the delegate to the proxy so the adapter can intercept events
    // default to the adapter simply being the delegate
    _collectionView.delegate = (id<UICollectionViewDelegate>)self.delegateProxy ?: self;
    _collectionView.dataSource = (id<UICollectionViewDataSource>)self.delegateProxy ?: self;
}

- (void)registeCellIfNeededUseCellClass:(Class)cellClass{
    NSString *cellIdentifier = NSStringFromClass(cellClass);
    if ([self.registedCellIdentifiers containsObject:cellIdentifier]) {
        return;
    }
    NSString *cellNibPath = [[NSBundle mainBundle] pathForResource:cellIdentifier ofType:@"nib"];
    if (cellNibPath){
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil]  forCellWithReuseIdentifier:cellIdentifier];
        [self.registedCellIdentifiers addObject:cellIdentifier];
    }else{
        [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:cellIdentifier];
        [self.registedCellIdentifiers addObject:cellIdentifier];
    }
}
- (void)registeSupplementaryViewIfNeededUseClass:(Class)supplementaryViewClass kind:(NSString *)kind{
    NSString *identifier = NSStringFromClass(supplementaryViewClass);
    if ([self.registedSupplementaryIdentifiers containsObject:identifier]) {
        return;
    }
    NSString *nibPath = [[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"];
    if (nibPath){
        [self.collectionView registerNib:[UINib nibWithNibName:nibPath bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
        [self.registedSupplementaryIdentifiers addObject:identifier];
    }else{
        [self.collectionView registerClass:supplementaryViewClass forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
        [self.registedSupplementaryIdentifiers addObject:identifier];
    }
}


@end
