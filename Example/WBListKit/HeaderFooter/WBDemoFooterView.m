//
//  WBDemoFooterView.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBDemoFooterView.h"

@implementation WBDemoFooterView

@synthesize headerFooter = _headerFooter;

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor redColor];
    self.textLabel.text = @"我是Footer";
    return self;
}

- (void)update{
    self.textLabel.text = @"我是Footer";
}


@end
