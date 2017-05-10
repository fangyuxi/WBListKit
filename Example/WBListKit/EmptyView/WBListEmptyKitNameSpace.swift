//
//  WBListEmptyKitNameSpace.swift
//  WBListKit
//
//  Created by Romeo on 2017/5/10.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import Foundation
import UIKit

public final class WBListEmptyKitNameSpace<Parent:NSObject>{
    public unowned let parent: Parent;
    public init(parent:Parent) {
        self.parent = parent;
    }
}


