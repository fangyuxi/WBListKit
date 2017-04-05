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

@interface WBCollectionViewAdapter ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak, readwrite) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *sections;
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
    
    //TO invoke header footer 'reload'
}

- (void)didDisappear{
    NSArray *cells = [self.collectionView visibleCells];
    
    [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UITableViewCell<WBCollectionCellProtocol> *cell = obj;
        if ([cell respondsToSelector:@selector(cancel)]) {
            [cell cancel];
        }
    }];
    
    //TO invoke header footer 'cancel'
}

#pragma mark section operators

- (WBCollectionSectionMaker *)sectionAtIndex:(NSUInteger)index{
    
    if (index >= self.sections.count)
    {
        return nil;
    }
    
    WBCollectionSection *section = [self.sections objectAtIndex:index];
    if (!section.maker) {
        WBCollectionSectionMaker *maker = [[WBCollectionSectionMaker alloc] initWithSection:section];
        section.maker = maker;
    }
    return section.maker;
}

- (WBCollectionSectionMaker *)sectionForIdentifier:(NSString *)identifier{
    
    __block WBCollectionSection *section = nil;
    [self.sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WBCollectionSection *tmpSection = (WBCollectionSection *)obj;
        if ([tmpSection.identifier isEqualToString:identifier])
        {
            section = tmpSection;
            BOOL b = true;
            stop = &b;
        }
    }];
    if (!section) {
        return nil;
    }
    if (!section.maker) {
        WBCollectionSectionMaker *maker = [[WBCollectionSectionMaker alloc] initWithSection:section];
        section.maker = maker;
    }
    return section.maker;
}

- (NSUInteger)indexOfSection:(WBCollectionSection *)section{
    return [self.sections indexOfObject:section];
}

- (void)addSection:(void(^)(WBCollectionSectionMaker *maker))block{
    [self insertSection:block atIndex:[self.sections count]];
}

- (void)insertSection:(void(^)(WBCollectionSectionMaker *maker))block
              atIndex:(NSUInteger)index
{
    if (index > self.sections.count)
    {
        return;
    }
    
    WBCollectionSection *section = [[WBCollectionSection alloc] init];
    WBCollectionSectionMaker *maker = [[WBCollectionSectionMaker alloc] initWithSection:section];
    section.maker = maker;
    [self.sections insertObject:maker.section atIndex:index];
    block(maker);
    
    //    if (maker.animationUpdate) {
    //        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:maker.animationType];
    //    }
}

- (void)updateSection:(WBCollectionSection *)section
             useMaker:(void(^)(WBCollectionSectionMaker *maker))block
{
    block(section.maker);
}

- (void)updateSectionAtIndex:(NSUInteger)index
                    useMaker:(void(^)(WBCollectionSectionMaker *maker))block
{
    WBCollectionSectionMaker *maker = [self sectionAtIndex:index];
    if (maker.section) {
        [self updateSection:maker.section useMaker:^(WBCollectionSectionMaker * _Nonnull maker) {
            block(maker);
        }];
        
        //        if (maker.animationUpdate) {
        //            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:maker.animationType];
        //        }
    }
}

- (void)updateSectionForIdentifier:(NSString *)identifier
                          useMaker:(void(^)(WBCollectionSectionMaker *maker))block
{
    WBCollectionSectionMaker *maker = [self sectionForIdentifier:identifier];
    if (maker.section) {
        [self updateSection:maker.section useMaker:^(WBCollectionSectionMaker * _Nonnull maker) {
            block(maker);
        }];
        
        //        NSUInteger index = [self indexOfSection:maker.section];
        //        if (maker.animationUpdate) {
        //            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:maker.animationType];
        //        };
    }
}

- (void)deleteSection:(WBCollectionSection *)section{
    [self.sections removeObject:section];
}
- (void)deleteSectionAtIndex:(NSUInteger)index{
    WBCollectionSectionMaker *maker = [self sectionAtIndex:index];
    if (maker.section) {
        [self deleteSection:maker.section];
    }
}
- (void)deleteSectionForIdentifier:(NSString *)identifier{
    WBCollectionSectionMaker *maker = [self sectionForIdentifier:identifier];
    if (maker.section) {
        [self deleteSection:maker.section];
    }
}
- (void)deleteAllSections{
    [self.sections removeAllObjects];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    WBListKitAssertMainThread();
    return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    WBCollectionSectionMaker *maker = [self sectionAtIndex:section];
    return maker.itemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.collectionView registerClass:NSClassFromString(@"WBCollectionViewCell") forCellWithReuseIdentifier:@"WBCollectionViewCell"];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WBCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
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

@end
