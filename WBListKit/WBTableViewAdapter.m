//
//  WBListKitAdapter.m
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import "WBTableViewAdapter.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "WBTableViewDelegateProxy.h"
#import "WBTableHeaderFooterViewProtocal.h"
#import "WBTableCellProtocal.h"

@interface WBTableViewAdapter ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak, readwrite) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableSet *registedCellIdentifiers;
@property (nonatomic, strong) NSMutableSet *registedHeaderFooterIdentifiers;

@property (nonatomic, strong) WBTableViewDelegateProxy *delegateProxy;
@end

@implementation WBTableViewAdapter

#pragma mark bind unbind

- (void)bindTableView:(UITableView *)tableView{
    WBListKitAssert([tableView isKindOfClass:[UITableView class]], @"bindTableView 需要一个 UITableView实例");
    [self unBindTableView];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if (self.actionDelegate || self.tableDataSource) {
        [self updateTableDelegateProxy];
    }
}

- (void)unBindTableView{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.tableView = nil;
}

#pragma mark manage appearance

- (void)willAppear{
    NSArray *cells = [self.tableView visibleCells];
    
    [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UITableViewCell<WBTableCellProtocol> *cell = obj;
        if ([cell respondsToSelector:@selector(reload)]) {
            [cell reload];
        }
    }];
    
    //TO invoke header footer 'reload'
}

- (void)didDisappear{
    NSArray *cells = [self.tableView visibleCells];
    
    [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UITableViewCell<WBTableCellProtocol> *cell = obj;
        if ([cell respondsToSelector:@selector(cancel)]) {
            [cell cancel];
        }
    }];
    
    //TO invoke header footer 'cancel'
}

#pragma mark section operators

- (WBTableSectionMaker *)sectionAtIndex:(NSUInteger)index{
    
    if (index >= self.sections.count)
    {
        return nil;
    }
    
    WBTableSection *section = [self.sections objectAtIndex:index];
    WBTableSectionMaker *maker = [[WBTableSectionMaker alloc] initWithSection:section];
    return maker;
}

- (WBTableSectionMaker *)sectionForIdentifier:(NSString *)identifier{
    
    __block WBTableSection *section = nil;
    [self.sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        WBTableSection *tmpSection = (WBTableSection *)obj;
        if ([tmpSection.identifier isEqualToString:identifier])
        {
            section = tmpSection;
            BOOL b = true;
            stop = &b;
        }
    }];
    
    WBTableSectionMaker *maker = [[WBTableSectionMaker alloc] initWithSection:section];
    return maker;
}

- (NSUInteger)indexOfSection:(WBTableSection *)section{
    return [self.sections indexOfObject:section];
}

- (void)addSection:(void(^)(WBTableSectionMaker *maker))block{
     [self insertSection:block atIndex:[self.sections count]];
}

- (void)insertSection:(void(^)(WBTableSectionMaker *maker))block
              atIndex:(NSUInteger)index
{
    if (index > self.sections.count)
    {
        return;
    }
    
    WBTableSection *section = [[WBTableSection alloc] init];
    WBTableSectionMaker *maker = [[WBTableSectionMaker alloc] initWithSection:section];
    [self.sections insertObject:maker.section atIndex:index];
    block(maker);
}

- (void)updateSection:(WBTableSection *)section
            useMaker:(void(^)(WBTableSectionMaker *maker))block
{
    WBTableSectionMaker *maker = [[WBTableSectionMaker alloc] initWithSection:section];
    block(maker);
}

- (void)updateSectionAtIndex:(NSUInteger)index
                   useMaker:(void(^)(WBTableSectionMaker *maker))block
{
    WBTableSectionMaker *maker = [self sectionAtIndex:index];
    if (maker.section) {
        [self updateSection:maker.section useMaker:^(WBTableSectionMaker * _Nonnull maker) {
            block(maker);
        }];
    }
}

- (void)updateSectionForIdentifier:(NSString *)identifier
                           useMaker:(void(^)(WBTableSectionMaker *maker))block
{
    WBTableSectionMaker *maker = [self sectionForIdentifier:identifier];
    if (maker.section) {
        [self updateSection:maker.section useMaker:^(WBTableSectionMaker * _Nonnull maker) {
            block(maker);
        }];
    }
}

- (void)deleteSection:(WBTableSection *)section{
    [self.sections removeObject:section];
}
- (void)deleteSectionAtIndex:(NSUInteger)index{
    WBTableSectionMaker *maker = [self sectionAtIndex:index];
    if (maker.section) {
        [self deleteSection:maker.section];
    }
}
- (void)deleteSectionForIdentifier:(NSString *)identifier{
    WBTableSectionMaker *maker = [self sectionForIdentifier:identifier];
    if (maker.section) {
        [self deleteSection:maker.section];
    }
}
- (void)deleteAllSections{
    [self.sections removeAllObjects];
}

#pragma mark UITableviewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WBTableSectionMaker *maker = [self sectionAtIndex:indexPath.section];
    WBTableRow *row = maker.rowAtIndex(indexPath.row);
    Class cellClass = row.associatedCellClass;
    NSString *identifier = NSStringFromClass(cellClass);
    WBListKitAssert(!identifier || ![identifier isEqualToString:@""], @"row's associatedCellClass is nil");
    
    //registe if needed
    [self registeCellIfNeededUseCellClass:cellClass];
    
    UITableViewCell<WBTableCellProtocol> *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    WBListKitAssert([cell conformsToProtocol:@protocol(WBTableCellProtocol)],@"cell 必须遵守 WBTableCellProtocol 协议");
    if ([cell respondsToSelector:@selector(reset)]) {
        [cell reset];
    }
    row.indexPath = indexPath;
    cell.row = row;
    if ([cell respondsToSelector:@selector(setActionDelegate:)]) {
        cell.actionDelegate = self.actionDelegate;
    }
    [cell update];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    WBListKitAssertMainThread();
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WBTableSectionMaker *maker = [self sectionAtIndex:section];
    return maker.rowCount;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WBTableSectionMaker *maker = [self sectionAtIndex:indexPath.section];
    WBTableRow *row = maker.rowAtIndex(indexPath.row);
    Class cellClass = maker.rowAtIndex(indexPath.row).associatedCellClass;
    
    //registe if needed
    [self registeCellIfNeededUseCellClass:cellClass];

    if (row.height == WBListCellHeightAutoLayout) {
        
        CGFloat f = [tableView fd_heightForCellWithIdentifier:NSStringFromClass(row.associatedCellClass)
                                             cacheByIndexPath:indexPath
                                                configuration:^(UITableViewCell<WBTableCellProtocol> *cell) {
                                                    cell.row = row;
                                                    [cell update];
                                                }];
        return f;
    }
    if (row.calculateHeight) {
        CGFloat height = row.calculateHeight(row);
        return height;
    }
    
    return row.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    WBTableSectionMaker *maker = [self sectionAtIndex:section];
    WBTableSectionHeaderFooter *header = maker.section.header;
    if (!header) {
        return 0;
    }

    //registe if needed
    [self registeHeaderFooterIfNeededUseClass:header.associatedHeaderFooterClass];
    
    if (header.height == WBTableHeaderFooterHeightAutoLayout) {
        WBTableSectionMaker *maker = [self sectionAtIndex:section];
        return [self heightForHeaderFooter:header inSectoin:maker.section];
    }
    if (header.calculateHeight) {
        CGFloat height = header.calculateHeight(header);
        return height;
    }
    return header.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    WBTableSectionMaker *maker = [self sectionAtIndex:section];
    WBTableSectionHeaderFooter *footer = maker.section.footer;
    if (!footer) {
        return 0;
    }
    
    //registe if needed
    [self registeHeaderFooterIfNeededUseClass:footer.associatedHeaderFooterClass];
    
    if (footer.height == WBTableHeaderFooterHeightAutoLayout) {
        WBTableSectionMaker *maker = [self sectionAtIndex:section];
        return [self heightForHeaderFooter:footer inSectoin:maker.section];
    }
    if (footer.calculateHeight) {
        CGFloat height = footer.calculateHeight(footer);
        return height;
    }
    return footer.height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WBTableSectionMaker *maker = [self sectionAtIndex:section];
    WBTableSectionHeaderFooter *header = maker.section.header;
    if (!header) {
        return nil;
    }
    NSString *headerIdentifier = NSStringFromClass(header.associatedHeaderFooterClass);
    
    //registe if needed
    [self registeHeaderFooterIfNeededUseClass:header.associatedHeaderFooterClass];
    
    UITableViewHeaderFooterView<WBTableHeaderFooterViewProtocal> *headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    WBListKitAssert([headerView isKindOfClass:[UITableViewHeaderFooterView class]],@"header 必须是 UITableViewHeaderFooterView的子类");
    WBListKitAssert([headerView conformsToProtocol:@protocol(WBTableHeaderFooterViewProtocal)],@"header 必须遵守 WBListHeaderFooterViewProtocal 协议");
    if ([headerView respondsToSelector:@selector(reset)]) {
        [headerView reset];
    }
    if ([headerView respondsToSelector:@selector(setActionDelegate:)]) {
        headerView.actionDelegate = self.actionDelegate;
    }
    headerView.headerFooter = header;
    [headerView update];
    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WBTableSectionMaker *maker = [self sectionAtIndex:section];
    WBTableSectionHeaderFooter *footer = maker.section.footer;
    if (!footer) {
        return nil;
    }
    NSString *footerIdentifier = NSStringFromClass(footer.associatedHeaderFooterClass);
    
    //registe if needed
    [self registeHeaderFooterIfNeededUseClass:footer.associatedHeaderFooterClass];
    
    UITableViewHeaderFooterView<WBTableHeaderFooterViewProtocal> *footerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
    WBListKitAssert([footerView isKindOfClass:[UITableViewHeaderFooterView class]],@"footer 必须是 UITableViewHeaderFooterView的子类");
    WBListKitAssert([footerView conformsToProtocol:@protocol(WBTableHeaderFooterViewProtocal)],@"footer 必须遵守 WBListHeaderFooterViewProtocal 协议");
    if ([footerView respondsToSelector:@selector(reset)]) {
        [footerView reset];
    }
    if ([footerView respondsToSelector:@selector(setActionDelegate:)]) {
        footerView.actionDelegate = self.actionDelegate;
    }
    footerView.headerFooter = footer;
    [footerView update];
    return footerView;
}

#pragma mark setters

- (void)setTableDataSource:(id<UITableViewDataSource>)tableDataSource {
    if (_tableDataSource != tableDataSource) {
        _tableDataSource = tableDataSource;
        [self updateTableDelegateProxy];
    }
}

- (void)setActionDelegate:(id<WBListActionToControllerProtocol>)actionDelegate{
    if (_actionDelegate != actionDelegate) {
        _actionDelegate = actionDelegate;
        [self updateTableDelegateProxy];
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

- (NSMutableSet *)registedHeaderFooterIdentifiers
{
    if (!_registedHeaderFooterIdentifiers) {
        _registedHeaderFooterIdentifiers = [NSMutableSet set];
    }
    return _registedHeaderFooterIdentifiers;
}

- (NSMutableArray *)sections
{
    if (!_sections) {
        _sections = [NSMutableArray array];
    }
    return _sections;
}

#pragma mark private method

- (void)updateTableDelegateProxy
{
    // there is a known bug with accessibility and using an NSProxy as the delegate that will cause EXC_BAD_ACCESS
    // when voiceover is enabled. it will hold an unsafe ref to the delegate
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    
    self.delegateProxy = [[WBTableViewDelegateProxy alloc] initWithTableDataSourceTarget:_tableDataSource
                                                                         tableDelegateTarget:_actionDelegate
                                                                                 interceptor:self];
    
    // set up the delegate to the proxy so the adapter can intercept events
    // default to the adapter simply being the delegate
    _tableView.delegate = (id<UITableViewDelegate>)self.delegateProxy ?: self;
    _tableView.dataSource = (id<UITableViewDataSource>)self.delegateProxy ?: self;
}

- (CGFloat)heightForHeaderFooter:(WBTableSectionHeaderFooter *)headerFooter
                        inSectoin:(WBTableSection *)section{
    NSString *identifier = NSStringFromClass(headerFooter.associatedHeaderFooterClass);\
    UITableViewHeaderFooterView<WBTableHeaderFooterViewProtocal> *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    view.headerFooter = headerFooter;
    [view update];
    CGSize size = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}

- (void)registeCellIfNeededUseCellClass:(Class)cellClass{
    WBListKitAssert(cellClass, @"请关联WBListRow对象的Cell");

    NSString *cellIdentifier = NSStringFromClass(cellClass);
    
    if ([self.registedCellIdentifiers containsObject:cellIdentifier]) {
        return;
    }
    
    NSString *cellNibPath = [[NSBundle mainBundle] pathForResource:cellIdentifier ofType:@"nib"];
    if (cellNibPath)
    {
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:cellIdentifier];
        [self.registedCellIdentifiers addObject:cellIdentifier];
    }
    else
    {
        [self.tableView registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
        [self.registedCellIdentifiers addObject:cellIdentifier];
    }
}
- (void)registeHeaderFooterIfNeededUseClass:(Class)headerFooterClass{
    WBListKitAssert(headerFooterClass, @"请关联Footer和Header对象的View");
    NSString *footerHeaderIdentifier = NSStringFromClass(headerFooterClass);
    
    if ([self.registedHeaderFooterIdentifiers containsObject:footerHeaderIdentifier]) {
        return;
    }
    
    NSString *footerHeaderNibPath = [[NSBundle mainBundle] pathForResource:footerHeaderIdentifier ofType:@"nib"];
    if (footerHeaderNibPath)
    {
        [self.tableView registerNib:[UINib nibWithNibName:footerHeaderNibPath bundle:nil] forHeaderFooterViewReuseIdentifier:footerHeaderIdentifier];
        [self.registedHeaderFooterIdentifiers addObject:footerHeaderIdentifier];
    }
    else
    {
        [self.tableView registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:footerHeaderIdentifier];
        [self.registedHeaderFooterIdentifiers addObject:footerHeaderIdentifier];
    }
}

@end



