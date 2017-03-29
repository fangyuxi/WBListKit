//
//  WBSimpleListAutoLayoutCell.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBSimpleListAutoLayoutCell.h"
#import "Masonry.h"

@interface WBSimpleListAutoLayoutCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation WBSimpleListAutoLayoutCell

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
        make.top.equalTo(self.contentView.mas_top).offset(30);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
    }];
}

- (void)update{
    self.label.text = [NSString stringWithFormat:@"SimpleList AutoLayout Cell Index : %@",[[self.row.data objectForKey:@"title"] stringValue]];
}


@end
