//
//  WBCollectionViewCell.m
//  WBListKit
//
//  Created by fangyuxi on 2017/4/1.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBCollectionViewCell.h"

@implementation WBCollectionViewCell

@synthesize item = _item;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.contentView.backgroundColor = [UIColor blueColor];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    return self;
}

- (void)update{
}

@end
