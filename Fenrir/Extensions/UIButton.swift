//
//  UIButton.swift
//  Fenrir
//
//  Created by Bruno Rocha on 2/2/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension UIButton {
    
    fileprivate struct AssociatedKeys {
        static var isBeingTrackedByFenrir = "fenrir_isBeingTracked"
    }
    
    internal(set) var isBeingTrackedByFenrir: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isBeingTrackedByFenrir) as? Bool ?? false
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.isBeingTrackedByFenrir,
                newValue as Bool? ?? false,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    open override func didMoveToSuperview() {
        if isBeingTrackedByFenrir == false {
            let instance = Fenrir.instance
            addTarget(instance, action: #selector(instance.touched(button:)), for: .touchUpInside)
            isBeingTrackedByFenrir = true
        }
        super.didMoveToSuperview()
    }
}
