//
//  WBNestedTableViewCell.m
//  WBListKit
//
//  Created by fangyuxi on 2017/4/5.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBNestedTableViewCell.h"
#import "WBNestedCollectionViewCell.h"
#import "Masonry.h"

@interface WBNestedTableViewCell ()<WBListActionToControllerProtocol>

@property (nonatomic, strong) WBCollectionViewAdapter *adapter;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WBNestedTableViewCell

@synthesize row = _row;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.contentView.backgroundColor = [UIColor redColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.contentView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView.actionDelegate = self;
    
    [self makeLayout];
    
    self.adapter = [[WBCollectionViewAdapter alloc] init];
    self.collectionView.adapter = self.adapter;
    
    return self;
}

- (void)makeLayout{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)update{
    [self.adapter deleteAllElements];
    [self.collectionView reloadData];
    
    // data from ... anywhere
    
    [self.adapter addSection:^(WBCollectionSection * _Nonnull section) {
        section.key = @"WBNested";
        for (NSInteger index = 0; index < 100; ++index) {
            WBCollectionItem *item = [[WBCollectionItem alloc] init];
            item.associatedCellClass = [WBNestedCollectionViewCell class];
            item.data = @{@"title":@(index)
                          };
            [section addItem:item];
        }
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(40, 40);
}

@end
