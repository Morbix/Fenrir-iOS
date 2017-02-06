//
//  UIButton.swift
//  Fenrir
//
//  Created by Bruno Rocha on 2/2/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension UIView {
    open override class func initialize() {
        guard Fenrir.instance.automatic == true else {
            return
        }
        guard self === UIButton.self else {
            return
        }
        let originalMethod = #selector(UIButton.addTarget(_:action:for:))
        let newMethod = #selector(UIButton.fenrirSwizzled_addTarget(_:action:for:))
        Fenrir.instance.swizzle(method: originalMethod,
                                fromClass: self,
                                with: newMethod,
                                fromClass: self,
                                token: "fenrir.addTargetSwizzle", dontForceAdd: true)
    }
    
    @objc fileprivate func fenrirSwizzled_addTarget(_ target: Any?, action: Selector, for event: UIControlEvents) {
        guard let t = target else {
            self.fenrirSwizzled_addTarget(target, action: action, for: event)
            return
        }
        let newMethod = #selector(Fenrir.fenrirSwizzled_targetAction(sender:))
        Fenrir.instance.swizzle(method: action,
                                fromClass: type(of:t) as! AnyClass,
                                with: newMethod,
                                fromClass: Fenrir.self,
                                token: "\(String(describing: type(of:t)))\(action.description)")
        self.fenrirSwizzled_addTarget(target, action: action, for: event)
    }
    
}

extension Fenrir {
    @objc fileprivate func fenrirSwizzled_targetAction(sender: Any) {
        if let button = sender as? UIButton {
            Fenrir.instance.touched(button: button)
        }
        fenrirSwizzled_targetAction(sender: sender)
    }
}
