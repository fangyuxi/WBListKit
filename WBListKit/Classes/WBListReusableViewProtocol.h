//
//  WBListReusableViewProtocal.h
//  Pods
//
//  Created by fangyuxi on 2017/3/21.
//
//

#ifndef WBListReusableViewProtocal_h
#define WBListReusableViewProtocal_h

/**
 从view到controller的各种操作统一接口

 比如Cell中有一个button，需要发送网络请求，那么代码如下：
 'button.action = ^(){
 
 [self.actionDelegate actionFromView:self withEventTag:yourtag withParameterObject:cellModel];
 
 };'
 
 actionDelegate是从adapter中传到view中的实现了此协议的controller对象
*/

@protocol WBListActionToControllerProtocol <NSObject,UITableViewDelegate,UICollectionViewDelegate>
@optional

- (void)actionFromReusableView:(UIView *)view
          withEventTag:(NSString *)tag
   withParameterObject:(id)object;

@end


/**
 所有可重用的view必须遵守此协议，如cell header footer
 */
@protocol WBListReusableViewProtocol <NSObject>

/**
 当view将要显示，框架会自动调用此方法，可在此方法中，从model对象同步数据赋值给要显示的控件
 */
- (void)update;

@optional

@property (nonatomic, weak) id<WBListActionToControllerProtocol> actionDelegate;

/**
 当view将要被复用，框架会自动调用此方法，可在此方法中重置view的内容，例如:'imageView.image = nil'
 */
- (void)reset;

/**
 当view所在控制器消失后，框架会自动调用此方法，可在此方法中取消正在进行的异步操作，例如取消图片下载
 */
- (void)cancel;


/**
 同 'cancel' 方法相反，可以恢复之前正在进行的异步操作
 */
- (void)reload;

@end

#endif /* WBListReusableViewProtocal_h */
