//
//  WBReformerListCellReformer.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBReformerListCellReformer.h"

@interface WBReformerListCellReformer ()

@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *date;

@end

@implementation WBReformerListCellReformer

- (void)reformRawData:(id)data forRow:(WBTableRow *)row{
    
    if (![data isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.title = [[data objectForKey:@"title"] stringValue];
    NSDate *date = [data objectForKey:@"date"];
    self.date = [date description];
}

@end
