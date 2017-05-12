//
//  WBSwiftListViewController.swift
//  WBListKit
//
//  Created by fangyuxi on 2017/3/22.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import UIKit
import WBListKit

class WBSwiftListViewController: UIViewController,WBListActionToControllerProtocol,WBListEmptyKitDelegate,WBListEmptyKitDataSource {

    let tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    let adapter: WBTableViewAdapter = WBTableViewAdapter();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView);
        
        tableView.frame = view.bounds
        tableView.empty.delegate = self
        tableView.empty.dataSource = self
        
        adapter.bindTableView(tableView);
        adapter.actionDelegate = self
        self.loadData();
    }
    
    func loadData(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.tableView.reloadData();
            self.tableView.reloadEmptyView();
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
            
            self.adapter.addSection { (maker) in
                
                for i in 1..<10{
                    let row: WBTableRow = WBTableRow();
                    row.associatedCellClass = WBSwiftListCell.self
                    row.data = ["color":UIColor.clear, "index":i]
                    row.calculateHeight = {row in return 100.0};
                    maker.addRow()(row)
                }
            }
            
            self.tableView.reloadData();
            self.tableView.reloadEmptyView();
        })
    }
    
    func ignoredSectionsNumber(in view: UIView) -> [Int]? {
        return [0]
    }
    
    func emptyLabel(for emptyView: UIView, in view: UIView) -> UILabel? {
        let label = UILabel()
        label.text = "空页面"
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.red
        return label
    }
    
    func emptyButton(for emptyView: UIView, in view: UIView) -> UIButton? {
        let button = UIButton()
        button.setTitle("空页面按钮", for: UIControlState.normal)
        button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        
        return button
    }
}







