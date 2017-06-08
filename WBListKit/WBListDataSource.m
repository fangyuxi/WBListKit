//
//  WBListDataSource.m
//  WBListKit
//
//  Created by fangyuxi on 2017/3/22.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

#import "WBListDataSource.h"
#import "UIViewController+WBList.h"
#import "WBMustOverride.h"

@interface WBListDataSource ()<WBListActionToControllerProtocol>
@property (nonatomic, weak, nullable, readwrite) id<WBListDataSourceDelegate> delegate;
@end

@implementation WBListDataSource

#pragma mark init

- (nonnull instancetype)init{
    NSCAssert(NO, @"please use 'initWithDelegate' method, give a delegate object");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    return [self initWithDelegate:nil];
#pragma clang diagnostic pop
}

- (nullable instancetype)initWithDelegate:(nonnull id<WBListDataSourceDelegate>)delegate{
    NSCParameterAssert(delegate);
    self = [super init];
    _delegate = delegate;
    return self;
}

#pragma mark list

- (void)loadSource{
    WB_SUBCLASS_MUST_OVERRIDE;
    return;
}

- (void)loadMoreSource{
    NSAssert(NO, @"subclass must implementation loadMoreSource in WBListDataSource");
    return;
}

- (void)cancelLoad{
    NSAssert(NO, @"subclass must implementation cancelLoad in WBListDataSource");
    return;
}

@end

@implementation WBListDataSource(NotifyController)

- (void)notifyWillLoad{
    //first call controller's list property in WBList Category
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(list)]) {
            [[(UIViewController *)self.delegate list] sourceDidStartLoad:self];
        }
    }
    if ([self.delegate respondsToSelector:@selector(sourceDidStartLoad:)]) {
        [self.delegate sourceDidStartLoad:self];
    }
}

- (void)notifyWillLoadMore{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(list)]) {
            [[(UIViewController *)self.delegate list] sourceDidStartLoadMore:self];
        }
    }
    if ([self.delegate respondsToSelector:@selector(sourceDidStartLoadMore:)]) {
        [self.delegate sourceDidStartLoadMore:self];
    }
}

- (void)notifyDidFinishLoad{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(list)]) {
            [[(UIViewController *)self.delegate list] sourceDidFinishLoad:self];
        }
    }
    if ([self.delegate respondsToSelector:@selector(sourceDidFinishLoad:)]) {
        [self.delegate sourceDidFinishLoad:self];
    }
}

- (void)notifyDidFinishLoadMore{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(list)]) {
            [[(UIViewController *)self.delegate list] sourceDidFinishLoadMore:self];
        }
    }
    if ([self.delegate respondsToSelector:@selector(sourceDidFinishLoadMore:)]) {
        [self.delegate sourceDidFinishLoadMore:self];
    }
}

- (void)notifyDidReceviedExtraData:(nonnull id)data{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(list)]) {
            [[(UIViewController *)self.delegate list] source:self didReceviedExtraData:data];
        }
    }
    if ([self.delegate respondsToSelector:@selector(source:didReceviedExtraData:)]) {
        [self.delegate source:self didReceviedExtraData:data];
    }
}

- (void)notifyLoadError:(nonnull NSError *)error{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(list)]) {
            [[(UIViewController *)self.delegate list] source:self loadError:error];
        }
    }
    if ([self.delegate respondsToSelector:@selector(source:loadError:)]) {
        [self.delegate source:self loadError:error];
    }
}

- (void)notifyLoadMoreError:(nonnull NSError *)error{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(list)]) {
            [[(UIViewController *)self.delegate list] source:self loadMoreError:error];
        }
    }
    if ([self.delegate respondsToSelector:@selector(source:loadMoreError:)]) {
        [self.delegate source:self loadMoreError:error];
    }
}

- (void)notifySourceDidClear{
    if ([self.delegate isKindOfClass:[UIViewController class]]) {
        if ([self.delegate respondsToSelector:@selector(list)]) {
            [[(UIViewController *)self.delegate list] sourceDidClearAllData:self];
        }
    }
    if ([self.delegate respondsToSelector:@selector(sourceDidClearAllData:)]) {
        [self.delegate sourceDidClearAllData:self];
    }
}

@end
