//
//  WBExpandingCellReformer.h
//  WBListKit
//
//  Created by fangyuxi on 2017/5/24.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBListKit.h"

@interface WBExpandingCellReformer :NSObject<WBListDataReformerProtocol>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, assign) BOOL isExpanding;

@end
