//
//  WBSwiftListCell.swift
//  WBListKit
//
//  Created by fangyuxi on 2017/3/22.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import UIKit
import WBListKit
import Masonry

class WBSwiftListCell: UITableViewCell,WBTableCellProtocol {

    var row:WBTableRow!
    weak var actionDelegate: WBListActionToControllerProtocol!
    
    let label:UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        
        makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLayout() -> Void {
        label.mas_makeConstraints { (maker) in
            guard let make = maker else{
                return;
            }
            
            _ = make.center.equalTo()(self.contentView)
        }
    }
    
    func update(){
        let data = row.data as! Dictionary<String, Any>
        let index:Int? = data["index"] as? Int
        label.text = String(index!)
        self.backgroundColor = data["color"] as? UIColor
    }

}
