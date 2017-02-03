//
//  UITableViewController.swift
//  Fenrir
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
        DispatchQueue.once(token: "fenrir.tableViewSwizzle") {
            let originalSelector = #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
            let swizzledSelector = #selector(self.fenrirSwizzled_tableView(_:didSelectRowAt:))
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
        
    @objc fileprivate func fenrirSwizzled_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        Fenrir.instance.register(touchOn: cell!)
        fenrirSwizzled_tableView(tableView, didSelectRowAt: indexPath)
    }
    
    @objc fileprivate func emptyMethod(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("1")
    }
}
