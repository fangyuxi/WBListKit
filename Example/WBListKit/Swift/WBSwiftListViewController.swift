//
//  WBSwiftListViewController.swift
//  WBListKit
//
//  Created by fangyuxi on 2017/3/22.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import UIKit
import WBListKit

class WBSwiftListViewController: UIViewController,WBListActionToControllerProtocol {

    let tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    let adapter: WBTableViewAdapter = WBTableViewAdapter();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView);
        
        tableView.frame = view.bounds
        tableView.adapter = adapter;
        tableView.actionDelegate = self;
        self.loadData();
    }
    
    func loadData(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            
            self.adapter.addSection { (section) in
                
                for i in 1..<10{
                    let row: WBTableRow<AnyObject> = WBTableRow<AnyObject>();
                    row.associatedCellClass = WBSwiftListCell.self
                    row.data = ["color":UIColor.clear, "index":i] as AnyObject
                    row.calculateHeight = {row in return 100.0};
                    section.addRow(row);
                }
            }
            
            self.tableView.reloadData();
        })
    }
}







