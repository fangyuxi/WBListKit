//
//  WBWaterFallLayout.swift
//  WBListKit
//
//  Created by fangyuxi on 2017/4/11.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import UIKit

@objc protocol WaterFallLayoutDelegate: NSObjectProtocol {
    // 用来设置每一个cell的高度
    func heightForItemAtIndexPath(indexPath: IndexPath) -> CGFloat
}

class WaterFallLayout: UICollectionViewLayout {
    
    /// 共有多少列
    public var numberOfColums = 3 {
        didSet {
            // 初始化为0
            for _ in 0..<numberOfColums {
                maxYOfColums.append(0)
            }
        }
    }
    /// cell之间的间隙 默认为5.0
    var itemSpace: CGFloat = 5.0
    
    public weak var delegate: WaterFallLayoutDelegate?
    // 当item比较少(几百个)的时候建议缓存
    // 当有成千个item的时候建议其他方式计算
    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []
    // 初始都设置为0
    private var maxYOfColums: [CGFloat] = [0,0,0]
    /// 用于记录之前屏幕的宽度 便于在旋转的时候刷新视图
    private var oldScreenWidth: CGFloat = 0.0
    
    
    // 在这个方法里面计算好各个cell的LayoutAttributes 对于瀑布流布局, 只需要更改LayoutAttributes.frame即可
    // 在每次collectionView的data(init delete insert reload)变化的时候都会调用这个方法准备布局
    override func prepare() {
        super.prepare()
        if let collectionView = collectionView {
            if collectionView.numberOfSections == 0 {
                return
            }else{
                layoutAttributes = computeLayoutAttributes()
                // 设置为当前屏幕的宽度
                oldScreenWidth = UIScreen.main.bounds.width //deleted ()
            }
        }
    }
    
    // Apple建议要重写这个方法, 因为某些情况下(delete insert...)系统可能需要调用这个方法来布局
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.row]
        
    }
    
    // 必须重写这个方法来返回计算好的LayoutAttributes
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 返回计算好的layoutAttributes
        return layoutAttributes
    }
    
    // 返回collectionView的ContentSize -> 滚动范围
    //changed this -> override func collectionViewContentSize() -> CGSize to this->
    override var collectionViewContentSize:  CGSize {
        if maxYOfColums.max() == nil {
            return CGSize(width: 0.0, height: 0)
        }
        let maxY = maxYOfColums.max()!
        return CGSize(width: 0.0, height: maxY)
    }
    
    // 当collectionView的bounds(滚动, 或者frame变化)发生改变的时候就会调用这个方法
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // 旋转屏幕后刷新视图
        return newBounds.width != oldScreenWidth
        
    }
    // 计算所有的UICollectionViewLayoutAttributes
    func computeLayoutAttributes() -> [UICollectionViewLayoutAttributes] {
        let totalNums = collectionView!.numberOfItems(inSection: 0)
        let width = (collectionView!.bounds.width - itemSpace * CGFloat(numberOfColums + 1)) / CGFloat(numberOfColums)
        
        var x: CGFloat
        var y: CGFloat
        var height: CGFloat
        var currentColum: Int
        var indexPath: IndexPath
        var attributesArr: [UICollectionViewLayoutAttributes] = []
        
//        guard let unwapDelegate = delegate else {
//            assert(false, "需要设置代理")
//            return attributesArr
//        }
        
        for index in 0..<numberOfColums {
            self.maxYOfColums[index] = 0
        }
        for currentIndex in 0..<totalNums {
            indexPath = IndexPath(item: currentIndex, section: 0)
            
            //height = unwapDelegate.heightForItemAtIndexPath(indexPath: indexPath)
            height = CGFloat((arc4random() % 200) + 50);
            
            if currentIndex < numberOfColums {// 第一行直接添加到当前的列
                currentColum = currentIndex
                
            } else {// 其他行添加到最短的那一列
                // 这里使用!会得到期望的值
                let minMaxY = maxYOfColums.min()!
                currentColum = maxYOfColums.index(of: minMaxY)!
            }
            //            currentColum = currentIndex % numberOfColums
            x = itemSpace + CGFloat(currentColum) * (width + itemSpace)
            // 每个cell的y
            y = itemSpace + maxYOfColums[currentColum]
            // 记录每一列的最后一个cell的最大Y
            maxYOfColums[currentColum] = CGFloat(y + height)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 设置用于瀑布流效果的attributes的frame
            
            attributes.frame = CGRect.init(x: x, y: y, width: width, height: height)
            
            attributesArr.append(attributes)
        }
        return attributesArr
        
    }
}
