//
//  WBSwiftEmptyViewController.swift
//  WBListKit
//
//  Created by fangyuxi on 2017/5/12.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import UIKit

import UIKit
import WBListKit

class WBSwiftEmptyViewController: UIViewController {
    
    let tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    let adapter: WBTableViewAdapter = WBTableViewAdapter();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView);
        tableView.frame = view.bounds
        tableView.empty.delegate = self
        tableView.empty.dataSource = self
        tableView.actionDelegate = self;
        
        tableView.adapter = adapter;
        
        let leftItem: UIBarButtonItem = UIBarButtonItem(title: "增加", style: UIBarButtonItemStyle.plain, target: self, action: #selector(add))
        let rightItem: UIBarButtonItem = UIBarButtonItem(title: "清空", style: UIBarButtonItemStyle.plain, target: self, action: #selector(clear))
            
        self.navigationItem.rightBarButtonItems = [leftItem, rightItem]
            
        self.loadData();
    }
    
    func loadData(){
        reloadLater()
    }
    
    func reloadLater(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.tableView.reloadData()
            self.tableView.reloadEmptyView()
        })
    }
    
    func add(){
        
        self.adapter.addSection { (section) in
            
            for i in 1..<10{
//                let row: WBTableRow<Dictionary> = WBTableRow();
//                row.associatedCellClass = WBSwiftListCell.self
//                row.data = ["color":UIColor.clear, "index":i]
//                row.calculateHeight = {row in return 100.0};
//                section.addRow(row);
            }
        }
        
        reloadLater()
        
    }
    
    func clear(){
        adapter.deleteAllSections()
        reloadLater()
    }
}

extension WBSwiftEmptyViewController : WBListActionToControllerProtocol{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print( #function, #line, type(of: self))
    }
}

extension WBSwiftEmptyViewController : WBListEmptyKitDataSource{
    
    /// 可以在这些方法中通过ViewSource的delegate方法中拿到error code 根据error code 
    /// 返回特定的view
    
    // you can try
//    func ignoredSectionsNumber(in view: UIView) -> [Int]? {
//        return [0]
//    }
    
    // you can try
//    func emptyLabel(for emptyView: UIView, in view: UIView) -> UILabel? {
//        let label = UILabel()
//        label.text = "空页面"
//        label.textAlignment = NSTextAlignment.center
//        label.backgroundColor = UIColor.red
//        return label
//    }
    
    func emptyButton(for emptyView: UIView, in view: UIView) -> UIButton? {
        let button = UIButton()
        button.setTitle("空页面按钮演示，点击事件", for: UIControlState.normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        
        return button
    }
}

extension WBSwiftEmptyViewController : WBListEmptyKitDelegate{
    
    func emptyView(_ emptyView: UIView, button: UIButton, tappedInView: UIView) {
        print( #function, #line, type(of: self))
    }
    
    func emptyView(_ emptyView: UIView, tappedInView: UIView) {
        print( #function, #line, type(of: self))
    }
}

