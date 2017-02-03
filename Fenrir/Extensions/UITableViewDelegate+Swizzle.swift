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
        self.fenrirSwizzled_tableView(tableView, didSelectRowAt: indexPath)
    }
}
