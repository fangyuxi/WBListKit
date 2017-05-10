//
//  WBListEmptyKit.swift
//  WBListKit
//
//  Created by Romeo on 2017/5/10.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import Foundation

private var nameSpaceKey: Void?
private var dataSourceKey: Void?
private var delegateKey: Void?
private var emptyViewKey: Void?

/// 增加一个命名空间
public extension UIScrollView{
    public weak var empty: WBListEmptyKitNameSpace<UIScrollView>?{
        get{
            return objc_getAssociatedObject(self, &nameSpaceKey) as? WBListEmptyKitNameSpace<UIScrollView>
        }
        set{
            objc_setAssociatedObject(self, &nameSpaceKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

public extension WBListEmptyKitNameSpace where Parent: UIScrollView{
    
    // MARK: - EmptyDataSource
    public weak var emptyDataSource: WBListEmptyKitDataSource?{
        get{
            return objc_getAssociatedObject(self, &dataSourceKey) as? WBListEmptyKitDataSource
        }
        set{
            objc_setAssociatedObject(self, &dataSourceKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    // MARK: - EmptyDelegate
    public weak var emptyDataDelegate: WBListEmptyKitDelegate?{
        get{
            return objc_getAssociatedObject(self, &delegateKey) as? WBListEmptyKitDelegate
        }
        set{
            objc_setAssociatedObject(self, &delegateKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    // MARK: - EmptyView
    internal var emptyView: WBListEmptyKitEmptyView?{
        get{
            return objc_getAssociatedObject(self, &emptyViewKey) as? WBListEmptyKitEmptyView
        }
        set{
            objc_setAssociatedObject(self, &emptyViewKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}


