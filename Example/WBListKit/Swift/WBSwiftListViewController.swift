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
        adapter.bindTableView(tableView);
        adapter.actionDelegate = self
        self.loadData();
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func loadData(){
        
        adapter.addSection { (maker) in
            
            for i in 1..<10{
                let row: WBTableRow = WBTableRow();
                row.associatedCellClass = WBSwiftListCell.self
                row.data = ["color":UIColor.clear, "index":i]
                row.calculateHeight = {row in return 100.0};
                maker.addRow()(row)
            }
        }
    }
}
