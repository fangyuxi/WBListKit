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

/**
 所有自定义的UITableViewCell需要遵守这个协议，并合成row属性
 实现WBListReusableViewProtocol中的方法
 */
@class WBTableRow;

@protocol WBTableCellProtocol <WBListReusableViewProtocol>

@property (nonatomic, strong) WBTableRow *row;

@end

#endif /* WBTableCellProtocol_h */
