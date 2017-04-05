//
//  WBTableCellProtocol.h
//  Pods
//
//  Created by fangyuxi on 2017/3/21.
//
//

#ifndef WBTableCellProtocol_h
#define WBTableCellProtocol_h

#import "WBListReusableViewProtocol.h"

@class WBTableRow;

@protocol WBTableCellProtocol <WBListReusableViewProtocol>

@property (nonatomic, strong) WBTableRow *row;

@end

#endif /* WBTableCellProtocol_h */
