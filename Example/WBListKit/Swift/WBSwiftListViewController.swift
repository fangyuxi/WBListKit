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
        
//        adapter.addSection { (maker) in
//            
//            for i in 1..<10{
//                let row: WBTableRow = WBTableRow();
//                row.associatedCellClass = WBSwiftListCell.self
//                row.data = ["color":UIColor.clear, "index":i]
//                row.calculateHeight = {row in return 100.0};
//                maker.addRow()(row)
//            }
//        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            self.tableView.reloadData();
            self.tableView.reloadEmptyView();
        })
        
    }
}
