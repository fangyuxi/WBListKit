//
//  WBSimpleListCell.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBSimpleListCell.h"
#import "Masonry.h"

@interface WBSimpleListCell ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation WBSimpleListCell

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
    self.label.text = [NSString stringWithFormat:@"SimpleList self manage height Cell Index : %@",[[(NSDictionary *)self.row.data objectForKey:@"title"] stringValue]];
}


@end
