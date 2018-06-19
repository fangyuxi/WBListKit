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

@class WBTableSection;
@class WBTableRow;

NS_ASSUME_NONNULL_BEGIN

@protocol WBListActionToControllerProtocol;

@interface WBTableViewAdapter : NSObject

/**
 get section at index

 @param index 'index'
 */
- (WBTableSection *)sectionAtIndex:(NSInteger)index;

/**
 get section with identifier

 @param key 'key'
 @return section
 */
- (WBTableSection *)sectionForKey:(NSString *)key;

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
- (void)addSection:(void(^)(WBTableSection *newSection))block;

/**
 add section at index

 @param block 'block'
 @param index '指定位置'
 */
- (void)insertSection:(void(^)(WBTableSection *newSection))block
              atIndex:(NSUInteger)index;

/**
 给特定的位置插入一个新的section，**注意**要确保这个section和之前的不重复
 
 @param newSection 新添加的section
 @param index 插入的位置
 */
- (void)insertSection:(WBTableSection *)newSection forIndex:(NSUInteger)index;

/**
 添加setion，如果之前有过这个section，**注意**要确保这个setion和之前的不重复
 
 @param newSection 新添加的setion
 */
- (void)insertSection:(WBTableSection *)newSection;

/**
 更新指定位置的section

 @param index 'index'
 @param block 'block'
 */
- (void)updateSectionAtIndex:(NSUInteger)index
                   useBlock:(void(^)(WBTableSection *section))block;


/**
 更新指定的id的section

 @param key 'key'
 @param block 'block'
 */
- (void)updateSectionForKey:(NSString *)key
                           useBlock:(void(^)(WBTableSection *section))block;

- (void)exchangeSectionIndex:(NSInteger)index1
            withSectionIndex:(NSInteger)index2;

/**
 删除操作
 */
- (void)deleteSection:(WBTableSection *)section;
- (void)deleteSectionAtIndex:(NSUInteger)index;
- (void)deleteSectionForKey:(NSString *)key;
- (void)deleteAllSections;

/**
 当前关联的TableView
 */
@property (nonatomic, weak, readonly) UITableView *tableView;

@end

@interface WBTableViewAdapter (AutoDiffer)

/**
 在任何的更改前调用此方法，系统会记录你对如下的更改：
 1：section的增删，位置移动
 2：row的增删，位置的移动
 
 beginAutoDiffer 和 commitAutoDiffer 成对调用，且不能嵌套
 
 在调用 commitAutoDiffer 之后，会将上述更改提交，tableview会以动画的方式响应
 
 如果涉及到row和section的 reload操作，需要调用ReloadShortcut中的方法
 
 严格来讲，当你更新了数据源后，应该立即提交view显示,安全起见，方法内部会先调用 reloadDifferWithAnimation 方法， 将未提交更改的内容先提交一次
 */
- (void)beginAutoDiffer;
/**
 同 beginAutoDiffer 嵌套调用
 */
- (void)commitAutoDifferWithAnimation:(BOOL)animation;


/**
 在任何位置调用，可以将之前的更改统一提交，tableview会以动画的方式响应
 */
- (void)reloadDifferWithAnimation:(BOOL)animation;

@end

@interface WBTableViewAdapter (ReloadShortcut)

- (void)reloadRowAtIndex:(NSIndexPath *)indexPath
               animation:(UITableViewRowAnimation)animationType
              usingBlock:(void(^)(WBTableRow *row))block;

- (void)reloadRowAtIndex:(NSInteger )index
           forSectionKey:(NSString *)key
               animation:(UITableViewRowAnimation)animationType
              usingBlock:(void(^)(WBTableRow *row))block;

- (void)reloadSectionAtIndex:(NSInteger)index
                   animation:(UITableViewRowAnimation)animationType
                  usingBlock:(void(^)(WBTableSection *section))block;

- (void)reloadSectionForKey:(NSString *)key
                  animation:(UITableViewRowAnimation)animationType
                 usingBlock:(void(^)(WBTableSection *section))block;
@end

NS_ASSUME_NONNULL_END

