//
//  WBCollectionItem.h
//  Pods
//
//  Created by fangyuxi on 2017/3/28.
//
//

#import <Foundation/Foundation.h>
#import "WBListKitAssert.h"
#import "WBListKitMacros.h"
#import "WBListDiffableProtocol.h"

/**
 A Model for UICollectionView Cell
 */
WBListKit_SUBCLASSING_RESTRICTED
@interface WBCollectionItem : NSObject<WBListDiffableProtocol>

/**
 associated item data
 */
@property (nonatomic, strong, nullable) id data;

/**
 这一行的唯一标识，默认为对象内存地址
 */
@property (nonatomic, copy, nullable) NSString *key;

/**
 当reloadKey发生变化的时候，会在adapter的beginDiffer和commitDiffer的时候自动reload
 可以通过data的field自定义这个key的get方法，来达到数据源更改后，自动reload
 默认为Cell的关联Row的内存地址，如果更换了row，那么也能达到自动reload的效果，
 
 注意：你应该确保每一个row的reloadKey不同，因为计算差异是通过reloadkey来达到目的的，
 如果出现相同的情况，会出现不可预测的问题。
 
 同key的区别，key是只要这个row创建了就不会在变化了，因为外部可能随时会通过这个key来回去row对象
 reloadKey是可能会变化的，来提醒差异化计算改更新这条row了
 */
@property (nonatomic, copy, nonnull) NSString *reloadKey;

/**
 location in list
 */
@property (nonatomic, strong, nonnull) NSIndexPath *indexPath;

/**
 cell class name will be used as reuseIditifier
 cell class or nib will be automatically registed in tableview by kit
 for standard, the cell name must ended in 'cell' like HYCustomCell,otherwise will crash
 */
@property (nonatomic, strong, nonnull) Class associatedCellClass;

@end
