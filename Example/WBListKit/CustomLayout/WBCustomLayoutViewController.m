//
//  WBCustomLayoutViewController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/4/6.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBCustomLayoutViewController.h"
#import "JKSeparatorLayout.h"
#import "WBCollectionViewCell.h"
#import "WBCustomSeparatorView.h"
#import "WBListKit.h"

@interface WBCustomLayoutViewController ()<WBListActionToControllerProtocol, JKSeparatorLayoutDelegate>

@property (nonatomic, strong) WBCollectionViewAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WBCustomLayoutViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Collection List";
    self.view.backgroundColor = [UIColor redColor];
    
    JKSeparatorLayout *layout = [[JKSeparatorLayout alloc] init];
    layout.separatorLayoutDelegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    self.collectionView.actionDelegate = self;
    [self.view addSubview:self.collectionView];
    
    self.adapter = [[WBCollectionViewAdapter alloc] init];
    self.adapter.collectionViewDataSource = self;
    [self.adapter bindCollectionView:self.collectionView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(300, 100);
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //cell被电击后移动的动画
    [collectionView selectItemAtIndexPath:indexPath
                                 animated:YES
                           scrollPosition:UICollectionViewScrollPositionTop];
}

- (void)loadData{
    
    __weak typeof(self) weakSelf = self;
    [self.adapter addSection:^(WBCollectionSectionMaker * _Nonnull maker) {
        for (NSInteger index = 0; index < 10; ++index) {
            WBCollectionItem *item = [[WBCollectionItem alloc] init];
            item.associatedCellClass = [WBCollectionViewCell class];
            item.data = @{@"title":@(index)
                          };
            maker.addItem(item);
            
            WBCollectionSupplementaryItem *sep = [WBCollectionSupplementaryItem new];
            sep.associatedViewClass = [WBCustomSeparatorView class];
            sep.elementKind = SeparatorViewKind;
            [weakSelf.adapter addSupplementaryItem:sep
                                         indexPath:[NSIndexPath indexPathForItem:index
                                                                       inSection:0]];
        }
    }];
    
    [self.collectionView reloadData];
}


/**
 只是网上找了个例子，严格来讲，应该没一个cell 都有一个分隔符，这里面只返回了第一个cell的分隔符，只是
 演示一下cell和supplementaryview在自定义布局中的用法，模拟器中绿色的为分隔符

 @return indexpaths
 */
- (NSIndexPath *)indexPathForSeparator{
//    NSArray *indexPaths = [self.adapter indexPathsForSupplementaryViews];
//    if (indexPaths.count == 0) {
//        return nil;
//    }
//    return [indexPaths objectAtIndex:0];
    return [NSIndexPath indexPathForItem:0
                               inSection:0];
}


@end
