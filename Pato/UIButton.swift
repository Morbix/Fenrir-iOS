//
//  UIButton.swift
//  Pato
//
//  Created by Bruno Rocha on 2/2/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension UIButton {
    
    fileprivate struct AssociatedKeys {
        static var isBeingTrackedByPato = "pato_isBeingTracked"
    }
    
    internal(set) var isBeingTrackedByPato: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isBeingTrackedByPato) as? Bool ?? false
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.isBeingTrackedByPato,
                newValue as Bool? ?? false,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    open override func didMoveToSuperview() {
        if isBeingTrackedByPato == false {
            let instance = Pato.instance
            addTarget(instance, action: #selector(instance.touched(button:)), for: .touchUpInside)
            isBeingTrackedByPato = true
        }
        super.didMoveToSuperview()
    }
}
