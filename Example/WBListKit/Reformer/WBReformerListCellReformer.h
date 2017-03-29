//
//  WBReformerListCellReformer.h
//  WBListKit
//
//  Created by fangyuxi on 2017/3/21.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBListKit.h"

@interface WBReformerListCellReformer : NSObject<WBListDataReformerProtocol>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *date;

@end
