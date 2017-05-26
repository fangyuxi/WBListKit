//
//  WBWaterFallViewController.m
//  WBListKit
//
//  Created by fangyuxi on 2017/4/11.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBWaterFallViewController.h"
#import "OCAndSwift-Swift.h"
#import "WBListKit.h"
#import "WBCollectionViewCell.h"

@interface WBWaterFallViewController ()<WBListActionToControllerProtocol,WaterFallLayoutDelegate>

@property (nonatomic, strong) WBCollectionViewAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WBWaterFallViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Collection List";
    self.view.backgroundColor = [UIColor redColor];
    
    WaterFallLayout *layout = [[WaterFallLayout alloc] init];
    layout.numberOfColums = 3;
    layout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    
    self.adapter = [[WBCollectionViewAdapter alloc] init];
    [self.collectionView bindAdapter:self.adapter];
    self.collectionView.actionDelegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData];
    });
}

- (void)loadData{
    [self.adapter addSection:^(WBCollectionSectionMaker * _Nonnull maker) {
        for (NSInteger index = 0; index < 500; ++index) {
            WBCollectionItem *item = [[WBCollectionItem alloc] init];
            item.associatedCellClass = [WBCollectionViewCell class];
            item.data = @{@"title":@(index)
                          };
            maker.addItem(item);
        }
    }];
    
    [self.collectionView reloadData];
}

- (CGFloat)heightForItemAtIndexPathWithIndexPath:(NSIndexPath * _Nonnull)indexPath{
    return (arc4random() % 200) + 50;
}


@end
