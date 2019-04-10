//
//  WBListEmptyKit.swift
//  WBListKit
//
//  Created by fangyuxi on 2017/5/10.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import Foundation

fileprivate struct AssociatedKeys{
    static var nameSpaceKey: Void?
    static var dataSourceKey: Void?
    static var delegateKey: Void?
    static var emptyViewKey: Void?
}

public extension UIScrollView{

    var empty: WBListEmptyKitNameSpace<UIScrollView>{
        get{
            var nameSpace: WBListEmptyKitNameSpace? = objc_getAssociatedObject(self, &AssociatedKeys.nameSpaceKey) as? WBListEmptyKitNameSpace<UIScrollView>
            if nameSpace == nil {
                nameSpace = WBListEmptyKitNameSpace(parent: self);
                objc_setAssociatedObject(self, &AssociatedKeys.nameSpaceKey, nameSpace, .OBJC_ASSOCIATION_RETAIN)
            }
            return nameSpace!
        }
    }
}

public extension WBListEmptyKitNameSpace where Parent: UIScrollView{
    
    // MARK: - EmptyDataSource
    weak var dataSource: WBListEmptyKitDataSource?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.dataSourceKey) as? WBListEmptyKitDataSource
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.dataSourceKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    // MARK: - EmptyDelegate
    weak var delegate: WBListEmptyKitDelegate?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.delegateKey) as? WBListEmptyKitDelegate
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.delegateKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    // MARK: - EmptyView
    internal var emptyView: WBListEmptyKitEmptyView{
        get{
            if let view = objc_getAssociatedObject(self, &AssociatedKeys.emptyViewKey) as? WBListEmptyKitEmptyView{
                return view;
            }
            let view = WBListEmptyKitEmptyView()
            objc_setAssociatedObject(self, &AssociatedKeys.emptyViewKey, view, .OBJC_ASSOCIATION_RETAIN)
            self.setupEmptyView(view)
            return view;
        }
    }
    
    internal func setupEmptyView(_ view: WBListEmptyKitEmptyView){
        
        //layout
        if view.superview == nil  {
            parent.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: parent, attribute: .leading, multiplier: 1, constant: 0))
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: parent, attribute: .trailing, multiplier: 1, constant: 0))
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1, constant: 0))
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1, constant: 0))
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: parent, attribute: .width, multiplier: 1, constant: 0))
            parent.addConstraint(NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: parent, attribute: .height, multiplier: 1, constant: 0))
            
            /// vertical horizontal could flexable extend
            view.setContentHuggingPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.horizontal)
            view.setContentHuggingPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        }
        
        view.hide()
        
        //event
        self.emptyView.didTappedEmptyView = {emptyView in
            if self.delegate?.shouldAllowTap(emptyView: self.emptyView, for: self.parent) ?? true {
                self.delegate?.emptyView(self.emptyView, tappedInView: self.parent)
            }
        }
        self.emptyView.didTappedButton = {button in
            self.delegate?.emptyView(self.emptyView, button: button, tappedInView: self.parent)
        }
    }
    
    internal func configEmptyView(){
        guard let dataSource = self.dataSource else {
            return
        }
        
        var itemsCount = 0
        if let ignoredSections = dataSource.ignoredSectionsNumber(in: parent){
            itemsCount = self.itemCount(ignoredSectionNums: ignoredSections)
        }else{
            itemsCount = self.itemCount(ignoredSectionNums: [Int]())
        }
        
        if itemsCount == 0 {
            if self.emptyView.isHidden == true {
                
                if self.delegate?.shouldDisplay(emptyView: self.emptyView, for: parent) ?? true {
                    
                    self.emptyView.shouldFadeIn = self.delegate?.emptyView(self.emptyView, shouldFadeIn: parent) ?? true
                    self.parent.isScrollEnabled = self.delegate?.shouldAllowScroll(emptyView: self.emptyView, for: self.parent) ?? false
                    self.emptyView.backgroundColor = dataSource.backgroudColor(for: self.emptyView, in: self.parent) ?? self.parent.backgroundColor
                    self.emptyView.verticalOffset = dataSource.verticalOffset(for: self.emptyView, in: self.parent)
                    self.emptyView.label = dataSource.emptyLabel(for: self.emptyView, in: self.parent)
                    self.emptyView.button = dataSource.emptyButton(for: self.emptyView, in: self.parent)
                    self.emptyView.image = dataSource.emptyImage(for: self.emptyView, in: self.parent)
                    self.emptyView.customView = dataSource.customEmptyView(for: self.emptyView, in: self.parent)
                    
                    self.delegate?.emptyViewWillAppear(in: parent)
                    self.emptyView.show()
                    parent.bringSubviewToFront(self.emptyView)
                    self.delegate?.emptyViewDidAppear(in: parent)
                }
            }
        }
        else{
            self.delegate?.emptyViewWillDisAppear(in: parent)
            self.parent.isScrollEnabled = true
            self.emptyView.hide()
            self.delegate?.emptyViewDidDisAppear(in: parent)
        }
        
    }
}

extension WBListEmptyKitNameSpace where Parent: UIScrollView{
    
    func sectionCount() -> Int{
        if let tableView = parent as? UITableView {
            return tableView.numberOfSections;
        }
        if let collectionView = parent as? UICollectionView {
            return collectionView.numberOfSections;
        }
        return 0
    }
    
    func itemCount(ignoredSectionNums: [Int]) -> Int{
        var count = 0
        if let tableView = parent as? UITableView {
            for index in 0..<self.sectionCount(){
                if ignoredSectionNums.contains(index)  {
                    continue
                }
                count += tableView.numberOfRows(inSection: index)
            }
            return count
        }
        if let collectionView = parent as? UICollectionView {
            for index in 0..<self.sectionCount(){
                if ignoredSectionNums.contains(index) {
                    continue
                }
                count += collectionView.numberOfItems(inSection: index)
            }
            return count
        }
        return count
    }
    
    func itemCount(atSectionNum num: Int) -> Int{
        if let tableView = parent as? UITableView {
            return tableView.numberOfRows(inSection: num)
        }
        if let collectionView = parent as? UICollectionView {
            return collectionView.numberOfItems(inSection: num)
        }
        return 0
    }

}

public extension UIScrollView{
    
    func reloadEmptyView(){
        self.empty.configEmptyView()
    }
}
