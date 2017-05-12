//
//  WBListEmptyKitEmptyView.swift
//  WBListKit
//
//  Created by Romeo on 2017/5/10.
//  Copyright © 2017年 xcoder.fang@gmail.com. All rights reserved.
//

import Foundation

class  WBListEmptyKitEmptyView: UIView {
    
    // MARK 一下四个为互斥，只能存在一个，优先级从第一个到最后一个逐渐降低
    var customView: UIView?{
        willSet{
            if newValue != nil {
                imageView?.removeFromSuperview()
                label?.removeFromSuperview()
                button?.removeFromSuperview()
                customView?.removeFromSuperview()
            }else{
                customView?.removeFromSuperview()
            }
        }
        didSet(oldValue){
            if let view = customView {
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view)
                
                //布局
                self.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: verticalOffset))
                
                view.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
                view.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
                view.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
                view.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
            }
        }
    }
    var image: UIImage?{
        willSet{
            if newValue != nil {
                label?.removeFromSuperview()
                button?.removeFromSuperview()
                customView?.removeFromSuperview()
            }else{
                imageView?.removeFromSuperview()
            }
        }
        didSet{
            if let view = imageView{
                view.image = image
            }else{
                imageView = UIImageView(image: image)
                imageView?.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(imageView!)
                
                //布局
                self.addConstraint(NSLayoutConstraint(item: imageView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: imageView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: verticalOffset))
                
                imageView!.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
                imageView!.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
                imageView!.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
                imageView!.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
            }
        }
    }
    var label: UILabel?{
        willSet{
            if newValue != nil {
                button?.removeFromSuperview()
                customView?.removeFromSuperview()
                imageView?.removeFromSuperview()
            }else{
                label?.removeFromSuperview()
            }
        }
        didSet{
            if let view = label {
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view)
                
                //布局
                self.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 15))
                self.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -15))
                self.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: verticalOffset))
                
                view.setContentHuggingPriority(UILayoutPriorityDefaultLow, for: UILayoutConstraintAxis.horizontal)
            }
        }
    }
    var button: UIButton?{
        willSet{
            if newValue != nil{
                label?.removeFromSuperview()
                customView?.removeFromSuperview()
                imageView?.removeFromSuperview()
            }else{
                button?.removeFromSuperview()
            }
        }
        didSet{
            if let view = button{
                view.translatesAutoresizingMaskIntoConstraints = false
                button?.addTarget(self, action: #selector(didTapButton), for: UIControlEvents.touchUpInside)
                self.addSubview(view)
                
                //布局
                self.addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
                self.addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: verticalOffset))
                
                view.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
                view.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
                view.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.horizontal)
                view.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
            }
        }
    }
    
    var shouldFadeIn:Bool = true
    var verticalOffset: CGFloat = 0
    
    private var imageView: UIImageView?
    
    // Events
    var didTappedEmptyView:((WBListEmptyKitEmptyView) -> Void)?
    var didTappedButton:((UIButton) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapEmptyView(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// constraints
private extension WBListEmptyKitEmptyView {
    
    func removeAllConstraints() {
        self.removeConstraints(self.constraints)
    }
    
}

// event
private extension WBListEmptyKitEmptyView {
    
    @objc func didTapButton(_ button: UIButton) {
        didTappedButton?(button)
    }
    
    @objc func didTapEmptyView(_ gesture: UITapGestureRecognizer) {
        
        guard let emptyView = gesture.view as? WBListEmptyKitEmptyView else {
            return
        }
        
        didTappedEmptyView?(emptyView)
    }
}

// hittest
extension WBListEmptyKitEmptyView{

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event) else {
            return nil
        }
        if hitView.isKind(of: UIControl.classForCoder()) {
            return hitView
        }
        if hitView.isEqual(customView) {
            return hitView
        }
        return nil
    }
}

// show hide
extension WBListEmptyKitEmptyView{
    
    func show() -> Void{
        self.isHidden = false
        
        if shouldFadeIn {
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = 1
            })
        }else{
            self.alpha = 1
        }
    }
    
    func hide() -> Void{
        self.alpha = 0
        self.isHidden = true
    }
}
