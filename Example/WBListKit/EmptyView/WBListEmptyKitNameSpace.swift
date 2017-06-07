//
//  WBListEmptyKitNameSpace.swift
//  WBListKit
//
//  Created by Romeo on 2017/5/10.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import Foundation
import UIKit

//这个地方使用了泛型，所以暂时不支持OC混编

//https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html#//apple_ref/doc/uid/TP40014216-CH10-ID136

//OC版本的替代品

//https://github.com/dzenbot/DZNEmptyDataSet

public final class WBListEmptyKitNameSpace<Parent:NSObject>{
    public unowned let parent: Parent;
    public init(parent:Parent) {
        self.parent = parent;
    }
}
