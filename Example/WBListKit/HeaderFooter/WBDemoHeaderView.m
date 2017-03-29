//
//  WBDemoHeaderView.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBDemoHeaderView.h"
#import "Masonry.h"

@interface WBDemoHeaderView ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation WBDemoHeaderView

@synthesize headerFooter = _headerFooter;

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor redColor];
    
    self.label = [UILabel new];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.label];
    
    [self makeLayout];
    return self;
}

- (void)makeLayout{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
    }];
}

- (void)update{
    self.label.text = @"我是自动布局的Header";
}

@end
