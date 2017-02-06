//
//  Swizzler.swift
//  Fenrir
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension Fenrir {
    
    @objc func emptyMethod() {}
    
    func swizzle(method originalSelector: Selector, fromClass `class`: AnyClass , with swizzledSelector: Selector, fromClass swizzledClass: AnyClass, token: String, dontForceAdd: Bool = false) {
        DispatchQueue.once(token: token) {
            var originalMethod: Method! {
                return class_getInstanceMethod(`class`, originalSelector)
            }
            
            var swizzledMethod: Method! {
                return class_getInstanceMethod(`class`, swizzledSelector)
            }
            
            if originalMethod == nil {
                if dontForceAdd {
                    return
                }
                let emptyMethod = class_getInstanceMethod(Fenrir.self, #selector(Fenrir.emptyMethod))
                class_addMethod(`class`, originalSelector, method_getImplementation(emptyMethod), method_getTypeEncoding(emptyMethod))
            }
            
            if swizzledMethod == nil {
                let trueSwizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector)
                class_addMethod(`class`, swizzledSelector, method_getImplementation(trueSwizzledMethod), method_getTypeEncoding(trueSwizzledMethod))
            }
            
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
