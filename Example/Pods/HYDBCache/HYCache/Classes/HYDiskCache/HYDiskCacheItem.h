//
//  HYDiskCacheItem.h
//  Pods
//
//  Created by fangyuxi on 2017/1/17.
//
//

#import <Foundation/Foundation.h>

/**
 disk cache item
 */

@interface HYDiskCacheItem : NSObject

@property (nonatomic, copy)   NSString  *key;                   ///< key
@property (nonatomic, strong) NSData    *value;                 ///< value
@property (nonatomic, copy)   NSString  *fileName;              ///< filename key.md5 by default
@property (nonatomic, assign) NSInteger size;                   ///< size
@property (nonatomic, assign) NSInteger inTimeStamp;            ///< inCache time stamp
@property (nonatomic, assign) NSInteger lastAccessTimeStamp;    ///< the lasted access time stamp
@property (nonatomic, assign) NSInteger maxAge;                 ///< max age

@end
