//
//  HYFileStorage.h
//  Pods
//
//  Created by fangyuxi on 2017/1/18.
//
//

#import <Foundation/Foundation.h>

@interface HYFileStorage : NSObject


/**
 Designated initializer.

 Usually, you do not need to use this class out
 
 @param dataPath 'data'
 @param trashPath 'trash'
 @return 'HYFileStorage Instance'
 */
- (instancetype)initWithPath:(NSString *)dataPath
                   trashPath:(NSString *)trashPath NS_DESIGNATED_INITIALIZER;

// do not use
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
// do not use
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;


/**
 write data to file

 @param data 'data'
 @param fileName 'file name'
 @return 'is succeed'
 */
- (BOOL)writeData:(NSData *)data fileName:(NSString *)fileName;


/**
 get data from file

 @param fileName 'file name'
 @return 'is succeed'
 */
- (NSData *)fileReadWithName:(NSString *)fileName;


/**
 delete file

 @param fileName 'file name'
 @return 'is succeed'
 */
- (BOOL)fileDeleteWithName:(NSString *)fileName;


/**
 delete files

 @param fileNames 'file names'
 @return is succeed
 */
- (BOOL)fileDeleteWithNames:(NSArray *)fileNames;


/**
 move all file to trash path

 @return 'is succeed'
 */
- (BOOL)fileMoveAllToTrash;


/**
 delete all file in trash
 */
- (void)removeAllTrashFileInBackground;

@end
