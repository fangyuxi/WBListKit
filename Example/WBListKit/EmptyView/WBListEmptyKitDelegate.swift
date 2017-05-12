//
//  WBListEmptyKitDelegate.swift
//  WBListKit
//
//  Created by Romeo on 2017/5/10.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import Foundation
import UIKit

public protocol WBListEmptyKitDelegate: class{
    
    /// 是否要显示EmptyView
    func shouldDisplay(emptyView: UIView, for view: UIView) -> Bool
    
    /// 显示EmptyView的时候，是否允许View滚动
    func shouldAllowScroll(emptyView: UIView, for view: UIView) -> Bool
    
    /// EmptyVIew是否支持Tap
    func shouldAllowTap(emptyView: UIView, for view: UIView) -> Bool
    
    /// EmptyView 发生Tap事件
    func emptyView(_ emptyView: UIView, tappedInView: UIView)
    
    func emptyView(_ emptyView: UIView, button: UIButton, tappedInView: UIView)
    
    /// 显示emptyView的时候，是否要fade
    func emptyView(_ emptyView: UIView, shouldFadeIn: UIView) -> Bool
    
    /// empty view show hide
    
    func emptyViewWillAppear(in view: UIView)
    
    func emptyViewDidAppear(in view: UIView)
    
    func emptyViewWillDisAppear(in view: UIView)
    
    func emptyViewDidDisAppear(in view: UIView)
    
}

public extension WBListEmptyKitDelegate{
    
    /// 是否要显示EmptyView
    func shouldDisplay(emptyView: UIView, for view: UIView) -> Bool{
        return true
    }
    
    /// 显示EmptyView的时候，是否允许View滚动
    func shouldAllowScroll(emptyView: UIView, for view: UIView) -> Bool{
        return false
    }
    
    /// EmptyVIew是否支持Tap
    func shouldAllowTap(emptyView: UIView, for view: UIView) -> Bool{
        return true
    }
    
    /// EmptyView 发生Tap事件
    func emptyView(_ emptyView: UIView, tappedInView: UIView){
    }
    
    func emptyView(_ emptyView: UIView, button: UIButton, tappedInView: UIView){
    }
    
    func emptyView(_ emptyView: UIView, shouldFadeIn: UIView) -> Bool {
        return true
    }
    
    /// empty view show hide
    
    func emptyViewWillAppear(in view: UIView){
    }
    
    func emptyViewDidAppear(in view: UIView){
    }
    
    func emptyViewWillDisAppear(in view: UIView){
    }
    
    func emptyViewDidDisAppear(in view: UIView){
    }
}
