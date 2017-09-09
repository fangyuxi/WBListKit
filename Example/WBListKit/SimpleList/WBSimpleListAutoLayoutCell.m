//
//  WBSimpleListAutoLayoutCell.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import <WBListKit/WBListKit.h>
#import "WBSimpleListAutoLayoutCell.h"
#import <Masonry/Masonry.h>

@interface WBSimpleListAutoLayoutCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation WBSimpleListAutoLayoutCell{
    MASConstraint *_topConstraint;
}

@synthesize row = _row;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
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
        _topConstraint = make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
    }];
    [_topConstraint setOffset:30.0f];
}

- (void)update{
    self.label.text = [NSString stringWithFormat:@"SimpleList AutoLayout Cell Index : %@",[((NSDictionary *) self.row.data)[@"title"] stringValue]];
    [_topConstraint setOffset:[((NSDictionary *) self.row.data)[@"title"] floatValue]];
}


@end
