//
//  WBDemosCell.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/20.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBDemosCell.h"
#import "Masonry.h"

@interface WBDemosCell ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation WBDemosCell

@synthesize actionDelegate = _actionDelegate;
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
        make.center.equalTo(self.contentView);
    }];
}

- (void)update{
    self.label.text = [(NSDictionary *)self.row.data objectForKey:@"title"];
}

@end
