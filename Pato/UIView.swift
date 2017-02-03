//
//  UIView.swift
//  Pato
//
//  Created by Bruno Rocha on 2/2/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension UIView: PatoTrackeable {
    fileprivate struct AssociatedKeys {
        static var patoTag = "patoTag"
    }
    
    public var patoTag: String {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.patoTag) as? String ?? ""
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.patoTag,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
