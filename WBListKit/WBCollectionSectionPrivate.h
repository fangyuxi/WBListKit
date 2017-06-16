//
//  WBCollectionSectionPrivate.h
//  Pods
//
//  Created by fangyuxi on 2017/4/5.
//
//

#ifndef WBCollectionSectionPrivate_h
#define WBCollectionSectionPrivate_h

#import "WBCollectionSection.h"

NS_ASSUME_NONNULL_BEGIN


/**
 隐藏了section的实现，防止外部不使用maker而直接修改section
 */
@interface WBCollectionSection ()

@property (nonatomic, copy)NSArray *oldArray;
@property (nonatomic, strong) NSMutableArray *items;

- (void)recordOldArray;
- (void)resetOldArray;

@end

NS_ASSUME_NONNULL_END

#endif /* WBCollectionSectionPrivate_h */
