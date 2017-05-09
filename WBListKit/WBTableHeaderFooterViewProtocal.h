//
//  WBListHeaderFooterProtocal.h
//  Pods
//
//  Created by fangyuxi on 2017/3/20.
//
//

#ifndef WBTableHeaderFooterViewProtocal_h
#define WBTableHeaderFooterViewProtocal_h

#import "WBListReusableViewProtocol.h"

/**
 所有自定义的UITableView的Header或者Footer需要遵守这个协议
 */

@class WBTableSectionHeaderFooter;

@protocol WBTableHeaderFooterViewProtocal <WBListReusableViewProtocol>

@property (nonatomic, strong) WBTableSectionHeaderFooter *headerFooter;

@end

#endif /* WBTableHeaderFooterViewProtocal_h */
