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
    self.collectionView.adapter = self.adapter;
    self.collectionView.actionDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(50, 100 );
}

- (void)loadData{
    
    [self.adapter beginAutoDiffer];
    [self.adapter addSection:^(WBCollectionSection * _Nonnull section) {
        for (NSInteger index = 0; index < 10; ++index) {
            WBCollectionItem *item = [[WBCollectionItem alloc] init];
            item.associatedCellClass = [WBCollectionViewCell class];
            item.data = @{@"title":@(index)
                         };
            [section addItem:item];
        }
        WBCollectionSupplementaryItem *header = [WBCollectionSupplementaryItem new];
        header.associatedViewClass = [WBCollectionHeaderView class];
        header.elementKind = UICollectionElementKindSectionHeader;
        [self.adapter addSupplementaryItem:header
                                     indexPath:[NSIndexPath indexPathForItem:0
                                                                   inSection:0]];
    }];
    
//    [self.adapter addSection:^(WBCollectionSection * _Nonnull section) {
//        for (NSInteger index = 0; index < 100; ++index) {
//            WBCollectionItem *item = [[WBCollectionItem alloc] init];
//            item.associatedCellClass = [WBCollectionViewCell class];
//            item.data = @{@"title":@(index)
//                          };
//            [section addItem:item];
//        }
//    }];
    
    [self.adapter commitAutoDifferWithAnimation:YES];
}


- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WBCollectionSection *section = [self.adapter sectionAtIndex:indexPath.section];
    WBCollectionItem *item = [section itemAtIndex:0];
    
    [self.adapter beginAutoDiffer];
    [section deleteItem:item];
    [self.adapter commitAutoDifferWithAnimation:YES];
    
    for (NSInteger index = 0; index < 100; ++index) {

//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.adapter beginAutoDiffer];
//            WBCollectionSection *section = [self.adapter sectionAtIndex:0];
//            [section deleteItemAtIndex:0];
//            [self.adapter commitAutoDifferWithAnimation:YES];
//        });
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.adapter beginAutoDiffer];
//            WBCollectionSection *section = [self.adapter sectionAtIndex:0];
//            WBCollectionItem *item = [[WBCollectionItem alloc] init];
//            item.associatedCellClass = [WBCollectionViewCell class];
//            item.data = @{@"title":@(index)
//                          };
//            [section addItem:item];
//            section.key = @"FixedHeight";
//            [section insertItem:item atIndex:8];
//            [self.adapter commitAutoDifferWithAnimation:YES];
//        });
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            WBCollectionSection *section = [self.adapter sectionAtIndex:0];
//            [section deleteItemAtIndex:1];
//        });
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.adapter beginAutoDiffer];
//            WBCollectionSection *section = [self.adapter sectionAtIndex:0];
//            [section exchangeItemAtIndex:100 withIndex:4];
//            [self.adapter commitAutoDifferWithAnimation:YES];
//        });

//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.adapter beginAutoDiffer];
//                    [self.adapter addSection:^(WBCollectionSection * _Nonnull section) {
//                        for (NSInteger index = 0; index < 100; ++index) {
//                            WBCollectionItem *item = [[WBCollectionItem alloc] init];
//                            item.associatedCellClass = [WBCollectionViewCell class];
//                            item.data = @{@"title":@(index)
//                                          };
//                            [section addItem:item];
//                            section.key = @"FixedHeight";
//                        }
//                    }];
//
//                    [self.adapter commitAutoDifferWithAnimation:YES];
//                });
//            });
//        });
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(320, 20);
}


@end
