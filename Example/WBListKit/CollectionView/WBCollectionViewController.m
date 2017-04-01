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
    [self.collectionView registerClass:[WBCollectionViewCell class] forCellWithReuseIdentifier:@"WBCollectionViewCell"];
    
    self.adapter = [[WBCollectionViewAdapter alloc] init];
    self.adapter.actionDelegate = self;
    [self.adapter bindCollectionView:self.collectionView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (void)loadData{
    
    [self.adapter addSection:^(WBCollectionSectionMaker * _Nonnull maker) {
        for (NSInteger index = 0; index < 5; ++index) {
            WBCollectionItem *item = [[WBCollectionItem alloc] init];
            item.associatedCellClass = [WBCollectionViewCell class];
            item.data = @{@"title":@(index)
                         };
            maker.addItem(item).setIdentifier(@"FixedHeight");
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.collectionView reloadData];
        });
    });
}

@end
