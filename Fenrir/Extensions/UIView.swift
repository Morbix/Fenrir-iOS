//
//  UIView.swift
//  Fenrir
//
//  Created by Bruno Rocha on 2/2/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension UIView: FenrirTrackeable {
    fileprivate struct AssociatedKeys {
        static var fenrirTag = "fenrirTag"
    }
    
    public var fenrirTag: String {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fenrirTag) as? String ?? ""
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.fenrirTag,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
