//
//  AppDelegate.swift
//  Fenrir
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension UIResponder {
    open override class func initialize() {
        guard Fenrir.instance.automatic == true else {
            return
        }
        guard self is UIApplicationDelegate else {
            return
        }
        Fenrir.instance.swizzle(method: #selector(UIApplicationDelegate.applicationDidEnterBackground(_:)),
                                fromClass: self,
                                with: #selector(Fenrir.fenrirSwizzled_applicationDidEnterBackground(_:)),
                                fromClass: Fenrir.self,
                                token: "fenrir.delegateBackgroundSwizzle")
        Fenrir.instance.swizzle(method: #selector(UIApplicationDelegate.applicationWillTerminate(_:)),
                                fromClass: self,
                                with: #selector(Fenrir.fenrirSwizzled_applicationWillTerminate(_:)),
                                fromClass: Fenrir.self,
                                token: "fenrir.delegateTerminateSwizzle")
    }
}

extension Fenrir {
    @objc fileprivate func fenrirSwizzled_applicationDidEnterBackground(_ app: UIApplication) {
        Fenrir.instance.dispatchEventsIfNeeded(ignoreStackAmount: true)
        self.fenrirSwizzled_applicationDidEnterBackground(app)
    }
    
    @objc fileprivate func fenrirSwizzled_applicationWillTerminate(_ app: UIApplication) {
        Fenrir.instance.dispatchEventsIfNeeded(ignoreStackAmount: true)
        self.fenrirSwizzled_applicationWillTerminate(app)
    }
}
