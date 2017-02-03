//
//  UITableViewController.swift
//  Pato
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension UIViewController {

    open override class func initialize() {
        if self is UITableViewDelegate == false || self === UITableViewController.self {
            return
        }
        DispatchQueue.once(token: "pato.tableViewSwizzle") {
            let originalSelector = #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
            let swizzledSelector = #selector(self.patoSwizzled_tableView(_:didSelectRowAt:))
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
        
    @objc fileprivate func patoSwizzled_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        Pato.instance.register(touchOn: cell!)
        patoSwizzled_tableView(tableView, didSelectRowAt: indexPath)
    }
    
}
