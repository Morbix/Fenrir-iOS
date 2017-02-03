//
//  Swizzler.swift
//  Fenrir
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension Fenrir {
    
    @objc fileprivate func emptyMethod() {
        print("un")
    }
    
    func swizzle(method originalSelector: Selector, fromClass `class`: AnyClass , with swizzledSelector: Selector, fromClass swizzledClass: AnyClass, token: String) {
        DispatchQueue.once(token: token) {
            
            var originalMethod: Method! {
                return class_getInstanceMethod(`class`, originalSelector)
            }
            
            var swizzledMethod: Method! {
                return class_getInstanceMethod(`class`, swizzledSelector)
            }
            
            if originalMethod == nil {
                let emptySelector = #selector(self.emptyMethod)
                let emptyMethod = class_getInstanceMethod(Fenrir.self, emptySelector)
                class_addMethod(`class`, originalSelector, nil, nil)
                method_setImplementation(originalMethod, method_getImplementation(emptyMethod))
            }
            
            if swizzledMethod == nil {
                let trueSwizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector)
                class_addMethod(`class`, swizzledSelector, nil, nil)
                method_setImplementation(swizzledMethod, method_getImplementation(trueSwizzledMethod))
            }
            
            method_exchangeImplementations(originalMethod, swizzledMethod)
            
        }
    }
}
