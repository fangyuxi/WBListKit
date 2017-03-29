//
//  WBReformerListCell.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBReformerListCell.h"
#import "WBReformerListCellReformer.h"
#import "Masonry.h"

@interface WBReformerListCell ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *date;

@end

@implementation WBReformerListCell

@synthesize row = _row;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.title = [UILabel new];
    self.title.backgroundColor = [UIColor clearColor];
    self.title.textColor = [UIColor redColor];
    [self.contentView addSubview:self.title];
    
    self.date = [UILabel new];
    self.date.backgroundColor = [UIColor clearColor];
    self.date.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.date];
    
    [self makeLayout];
    return self;
}

- (void)makeLayout{
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.title.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

- (void)update{
    WBReformerListCellReformer *reformer = (WBReformerListCellReformer *)self.row.data;
    self.title.text = reformer.title;
    self.date.text = reformer.date;
}

@end
