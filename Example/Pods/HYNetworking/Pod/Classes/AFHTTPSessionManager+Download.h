//
//  AFNetworking+HYNetworking.h
//  Pods
//
//  Created by fangyuxi on 16/5/3.
//
//

#import "AFNetworking.h"

@interface AFHTTPSessionManager(Download)

- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSString *)URLString
                                         progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                      destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                          success:(void (^)(NSURLSessionDownloadTask *task, id responseObject))success
                                          failure:(void (^)(NSURLSessionDownloadTask *task, NSError *error))failure;

@end
