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
        guard Fenrir.instance.automatic == true else {
            return
        }
        viewDidAppearSwizzle()
        tableViewDelegateSwizzle()
    }
    
    class func viewDidAppearSwizzle() {
        guard self === UIViewController.self else {
            return
        }
        let originalMethod = #selector(UIViewController.viewDidAppear(_:))
        let newMethod = #selector(Fenrir.fenrirSwizzled_viewDidAppear(_:))
        Fenrir.instance.swizzle(method: originalMethod,
                                fromClass: self,
                                with: newMethod,
                                fromClass: Fenrir.self,
                                token: "fenrir.didAppearSwizzle")
    }
    
    class func tableViewDelegateSwizzle() {
        guard self === UITableViewController.self || (self.isSubclass(of: UITableViewController.self) == false && self is UITableViewDelegate) else {
            return
        }
        let originalMethod = #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
        let newMethod = #selector(Fenrir.fenrirSwizzled_tableView(_:didSelectRowAt:))
        Fenrir.instance.swizzle(method: originalMethod,
                                fromClass: self,
                                with: newMethod,
                                fromClass: Fenrir.self,
                                token: "\(self)fenrir.tableViewSwizzle")
    }
}

extension Fenrir {
    @objc fileprivate func fenrirSwizzled_tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        Fenrir.instance.register(touchOn: cell!)
        fenrirSwizzled_tableView(tableView, didSelectRowAt: indexPath)
    }
    
    @objc fileprivate func fenrirSwizzled_viewDidAppear(_ animated: Bool) {
        Fenrir.instance.registerFlow(self)
        fenrirSwizzled_viewDidAppear(animated)
    }
}
