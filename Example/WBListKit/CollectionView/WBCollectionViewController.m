//
//  WBCollectionViewController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/4/1.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBCollectionViewController.h"
#import "WBListKit.h"
#import "WBCollectionViewCell.h"
#import "WBCollectionHeaderView.h"

@interface WBCollectionViewController ()<WBListActionToControllerProtocol>

@property (nonatomic, strong) WBCollectionViewAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WBCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Collection List";
    self.view.backgroundColor = [UIColor redColor];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.view addSubview:self.collectionView];
    
    
    self.adapter = [[WBCollectionViewAdapter alloc] init];
    self.adapter.actionDelegate = self;
    self.adapter.collectionViewDataSource = self;
    [self.adapter bindCollectionView:self.collectionView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50, 100 );
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
        for (NSInteger index = 0; index < 100; ++index) {
            WBCollectionItem *item = [[WBCollectionItem alloc] init];
            item.associatedCellClass = [WBCollectionViewCell class];
            item.data = @{@"title":@(index)
                         };
            maker.addItem(item).setIdentifier(@"FixedHeight");
        }
        
        WBCollectionSupplementaryItem *header = [WBCollectionSupplementaryItem new];
        header.associatedViewClass = [WBCollectionHeaderView class];
        header.elementKind = UICollectionElementKindSectionHeader;
        [weakSelf.adapter addSupplementaryItem:header
                                     indexPath:[NSIndexPath indexPathForItem:0
                                                                   inSection:0]];
    }];
    
    [self.adapter addSection:^(WBCollectionSectionMaker * _Nonnull maker) {
        for (NSInteger index = 0; index < 100; ++index) {
            WBCollectionItem *item = [[WBCollectionItem alloc] init];
            item.associatedCellClass = [WBCollectionViewCell class];
            item.data = @{@"title":@(index)
                          };
            maker.addItem(item).setIdentifier(@"FixedHeight");
        }
        
        WBCollectionSupplementaryItem *header = [WBCollectionSupplementaryItem new];
        header.associatedViewClass = [WBCollectionHeaderView class];
        header.elementKind = UICollectionElementKindSectionHeader;
        [weakSelf.adapter addSupplementaryItem:header
                                     indexPath:[NSIndexPath indexPathForItem:0
                                                                   inSection:1]];
    }];
    
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(320, 20);
}

@end
