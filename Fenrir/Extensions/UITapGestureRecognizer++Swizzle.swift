//
//  UITapGestureRecognizer++Swizzle.swift
//  Fenrir
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension UITapGestureRecognizer {
    open override class func initialize() {
        let originalMethod = #selector(UITapGestureRecognizer.init(target:action:))
        let newMethod = #selector(UITapGestureRecognizer.init(ta:ac:))
        Fenrir.instance.swizzle(method: originalMethod,
                                fromClass: self,
                                with: newMethod,
                                fromClass: Fenrir.self,
                                token: "fenrir.tapGestureInitSwizzle")
    }
    
    @objc fileprivate convenience init(ta: Any?, ac: Selector?) {
        guard let t = ta, let a = ac else {
            self.init(ta: ta, ac: ac)
            return
        }
        let newMethod = #selector(Fenrir.fenrirSwizzled_gestureAction(sender:))
        Fenrir.instance.swizzle(method: a,
                                fromClass: type(of:t) as! AnyClass,
                                with: newMethod,
                                fromClass: Fenrir.self,
                                token: "\(String(describing: type(of:t)))\(a.description)")
        self.init(ta: t, ac: a)
    }
}

extension Fenrir {
    @objc fileprivate func fenrirSwizzled_gestureAction(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            Fenrir.instance.touched(gestureView: view)
        }
        fenrirSwizzled_gestureAction(sender: sender)
    }
}
