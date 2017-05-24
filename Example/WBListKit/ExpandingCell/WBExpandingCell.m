//
//  WBExpandingCell.m
//  WBListKit
//
//  Created by Romeo on 2017/5/24.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBExpandingCell.h"
#import "WBExpandingCellReformer.h"
#import "Masonry.h"

@interface WBExpandingCell ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation WBExpandingCell{
    MASConstraint *_topConstraint;
    MASConstraint *_bottomConstraint;
}

@synthesize row = _row;
@synthesize actionDelegate = _actionDelegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.button];
    [self makeLayout];
    
    return self;
}

- (void)makeLayout{
    self.button.mas_key = @"button";
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        _topConstraint = make.top.equalTo(self.contentView);
        _bottomConstraint = make.bottom.equalTo(self.contentView);
    }];
}

- (void)update{
    WBExpandingCellReformer *reformer = self.row.data;
    if (reformer.isExpanding) {
        _topConstraint.offset = 80.0f;
        _bottomConstraint.offset = -80.0f;
    }else{
        _topConstraint.offset = 30.0f;
        _bottomConstraint.offset = -30.0f;
    }
    [_button setTitle:reformer.title forState:UIControlStateNormal];
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor redColor];
        [_button addTarget:self action:@selector(expandding) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)expandding{
    [self.actionDelegate actionFromReusableView:self
                                       eventTag:@"expanding"
                                      parameter:self.row];
}

@end
