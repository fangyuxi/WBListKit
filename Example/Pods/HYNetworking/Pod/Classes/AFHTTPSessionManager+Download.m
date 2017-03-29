//
//  AFNetworking+HYNetworking.m
//  Pods
//
//  Created by fangyuxi on 16/5/3.
//
//

#import "AFHTTPSessionManager+Download.h"

@implementation AFHTTPSessionManager(Download)

- (NSURLSessionDownloadTask *)downloadTaskWithURL:(NSString *)URLString
                                         progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                      destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                          success:(void (^)(NSURLSessionDownloadTask *task, id response))success
                                          failure:(void (^)(NSURLSessionDownloadTask *task, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:nil error:&serializationError];
    if (serializationError)
    {
        if (failure)
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDownloadTask *dataTask = nil;
    dataTask = [self downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:^(NSURLResponse * __unused response, NSURL * path, NSError *error)
                {
                    if (error)
                    {
                        if (failure)
                        {
                            failure(dataTask, error);
                        }
                    }
                    else
                    {
                        if (success)
                        {
                            success(dataTask, response);
                        }
                    }
                }];
    
    [dataTask resume];
    
    return dataTask;
}

@end
