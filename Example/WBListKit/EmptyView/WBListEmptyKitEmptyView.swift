//
//  WBListEmptyKitEmptyView.swift
//  WBListKit
//
//  Created by Romeo on 2017/5/10.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import Foundation

class WBListEmptyKitEmptyView: UIView {
    
    // MARK event
    var tappedAction: ((WBListEmptyKitEmptyView) -> Void)?
    
    // MARK custom controls
    var customView: UIView?
    var label: UILabel?
    var button: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
