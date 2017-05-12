//
//  WBListEmptyKitDataSource.swift
//  WBListKit
//
//  Created by Romeo on 2017/5/10.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import Foundation
import UIKit

/// EmptyView 的 DataSource，用于配置EmptyView的样式等
public protocol WBListEmptyKitDataSource: class {
    
    /// 单独一张图片
    func emptyImage(for emptyView:UIView, in view: UIView) -> UIImage?
    
    /// 单独的一个按钮
    func emptyButton(for emptyView:UIView, in view: UIView) -> UIButton?
    
    /// 单独的一段文本
    func emptyLabel(for emptyView:UIView, in view: UIView) -> UILabel?
    
    /// 自己定制的一个UIView
    func customEmptyView(for emptyView: UIView , in view: UIView) -> UIView?
    
    ///  返回emptyView的动画
    func animation(for emptyView: UIView, in view: UIView) -> CAAnimation?
    
    /// emptyView的背景颜色
    func backgroudColor(for emptyView:UIView, in view: UIView) -> UIColor?
    
    /// 竖向的offset 默认在View的中间位置
    func verticalOffset(for emptyView:UIView, in view: UIView) -> CGFloat
    
    /// 在统计列表为空的情况下是否忽略一些section
    func ignoredSectionsNumber(in view: UIView) -> [Int]?
}

/// 提供一些默认实现
public extension WBListEmptyKitDataSource{
    
    func emptyImage(for emptyView:UIView, in view: UIView ) -> UIImage?{
        return nil
    }
    
    func emptyButton(for emptyView:UIView, in view: UIView) -> UIButton?{
        return nil
    }
    
    func emptyLabel(for emptyView:UIView, in view: UIView) -> UILabel?{
        return nil
    }
    
    func customEmptyView(for emptyView: UIView , in view: UIView) -> UIView?{
        return nil
    }
    
    func animation(for emptyView: UIView, in view: UIView) -> CAAnimation?{
        return nil
    }
    func verticalOffset(for emptyView:UIView, in view: UIView) -> CGFloat{
        return 0
    }
    
    func ignoredSectionsNumber(in view: UIView) -> [Int]?{
        return nil
    }
    
    func backgroudColor(for emptyView:UIView, in view: UIView) -> UIColor?{
        return view.backgroundColor
    }
}

/// 如果控制器实现了这个协议，那么判断是否需要去掉导航栏的高度
public extension WBListEmptyKitDataSource where Self: UIViewController{
    
    func verticalOffset(for emptyView:UIView, in view: UIView) -> CGFloat {
        if let nav = self.navigationController, !nav.isNavigationBarHidden, nav.navigationBar.isTranslucent {
            return -nav.navigationBar.frame.maxY
        }
        return 0
    }
}
