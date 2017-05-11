//
//  WBListEmptyKitDelegate.swift
//  WBListKit
//
//  Created by Romeo on 2017/5/10.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import Foundation
import UIKit

public protocol WBListEmptyKitDelegate: class {
    
    func emptyViewWillAppear(in view: UIView)
    
    func emptyViewDidAppear(in view: UIView)
    
    func emptyViewWillDisAppear(in view: UIView)
    
    func emptyViewDidDisAppear(in view: UIView)
    
}
