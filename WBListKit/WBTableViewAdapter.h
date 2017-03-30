//
//  WBListKitAdapter.h
//  Pods
//
//  Created by fangyuxi on 2017/3/17.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"
#import "WBTableSectionMaker.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WBListActionToControllerProtocol;

@interface WBTableViewAdapter : NSObject

/**
 绑定tableView
 当Adapter和TableView出现多对一情况的时候，重新绑定即可
 @param tableView 'tableView'
 */
- (void)bindTableView:(UITableView *)tableView;

/**
 解绑TableView
 */
- (void)unBindTableView;

/**
 可以在'viewWillAppear' 和 'viewDidDisappear' 中调用，用来回调cell/header/footer
 中的 'cancel' 'reload' 方法
 */
- (void)willAppear;
- (void)didDisappear;

@property (nonatomic, weak, readonly) UITableView *tableView;

/**
 you should use these method to manage tableview's and datasource
 please avoid direct use tableview's delegate and datasource property
 
 before use it, you must know why 
 */
@property (nonatomic, weak) id<UITableViewDataSource> tableDataSource;

/**
 look into WBListCell, adapter is a brige for actions transport from cell to controller
 inherits UITableViewDelegate Protolcol, contains All actions from cell
 */
@property (nonatomic, weak) id<WBListActionToControllerProtocol> actionDelegate;

/**
 get section at index

 @param index 'index'
 */
- (WBTableSectionMaker *)sectionAtIndex:(NSUInteger)index;

/**
 get section with identifier

 @param identifier 'identifier'
 @return section
 */
- (WBTableSectionMaker *)sectionForIdentifier:(NSString *)identifier;

/**
 get index of section
 
 @param section 'section'
 @return index
 */
- (NSUInteger)indexOfSection:(WBTableSection *)section;

/**
 append section

 @param block 'block'
 */
- (void)addSection:(void(^)(WBTableSectionMaker *maker))block;

/**
 add section at index

 @param block 'block'
 @param index '指定位置'
 */
- (void)insertSection:(void(^)(WBTableSectionMaker *maker))block
              atIndex:(NSUInteger)index;

/**
 update section

 @param section 'section'
 @param block   'block'
 */
- (void)updateSection:(WBTableSection *)section
            useMaker:(void(^)(WBTableSectionMaker *maker))block;

/**
 更新指定位置的section

 @param index 'index'
 @param block 'block'
 */
- (void)updateSectionAtIndex:(NSUInteger)index
                   useMaker:(void(^)(WBTableSectionMaker *maker))block;


/**
 更新指定的id的section

 @param identifier 'identifier'
 @param block 'block'
 */
- (void)updateSectionForIdentifier:(NSString *)identifier
                           useMaker:(void(^)(WBTableSectionMaker *maker))block;

/**
 删除操作
 */
- (void)deleteSection:(WBTableSection *)section;
- (void)deleteSectionAtIndex:(NSUInteger)index;
- (void)deleteSectionForIdentifier:(NSString *)identifier;
- (void)deleteAllSections;

@end

NS_ASSUME_NONNULL_END

