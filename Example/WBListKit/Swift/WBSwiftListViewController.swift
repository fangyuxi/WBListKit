//
//  WBSwiftListViewController.swift
//  WBListKit
//
//  Created by fangyuxi on 2017/3/22.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import UIKit
import WBListKit

class WBSwiftListViewController: UIViewController {

    let tableView: UITableView = UITableView(frame: .zero, style: UITableViewStyle.plain)
    let adapter: WBTableViewAdapter = WBTableViewAdapter();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView);
        adapter.bindTableView(tableView);
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
                row.height = 100.0;
                row.associatedCellClass = WBSwiftListCell.self
                row.data = ["color":UIColor.clear, "index":i]
                maker.addRow()(row)
            }
        }
    }
}
