//
//  WBTableSectionPrivate.h
//  Pods
//
//  Created by Romeo on 2017/6/14.
//
//

#ifndef WBTableSectionPrivate_h
#define WBTableSectionPrivate_h

#import "WBTableSection.h"
#import "WBTableHeaderFooterViewProtocal.h"

@interface WBTableSection ()

@property (nonatomic, copy)NSArray *oldArray;
@property (nonatomic, strong) NSMutableArray *rows;

- (void)recordOldArray;
- (void)resetOldArray;

@end

#endif /* WBTableSectionPrivate_h */
