//
//  ViewController.swift
//  meditacaoprototype
//
//  Created by Bruno Rocha on 1/31/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit
import Foundation

open class Fenrir: NSObject {
    
    open static let instance = Fenrir()
    
    open var isTracking: Bool = false
    open var debugMode: Bool = false
    open var stackAmount: Int? = 1
    
    var storedEvents: [[String: Any]] = []
    var currentScreen: String?
    var eventHandler: (([String:Any]) -> Void)?
    
}

//MARK: Setup and Delegate Swizzle

extension Fenrir {
    open func setup(eventHandler: (([String:Any]) -> Void)?) {
        self.eventHandler = eventHandler
        let appDelegateClass = type(of:UIApplication.shared.delegate!).self
        Fenrir.instance.swizzle(method: #selector(UIApplicationDelegate.applicationDidEnterBackground(_:)),
                                fromClass: appDelegateClass,
                                with: #selector(Fenrir.applicationDidEnterBackground(_:)),
                                fromClass: Fenrir.self,
                                token: "fenrir.delegateBackgroundSwizzle")
        
        Fenrir.instance.swizzle(method: #selector(UIApplicationDelegate.applicationWillTerminate(_:)),
                                fromClass: appDelegateClass,
                                with: #selector(Fenrir.applicationWillTerminate(_:)),
                                fromClass: Fenrir.self,
                                token: "fenrir.delegateTerminateSwizzle")
    }
    
    @objc fileprivate func applicationDidEnterBackground(_ app: UIApplication) {
        Fenrir.instance.dispatchEventsIfNeeded(ignoreStackAmount: true)
        self.applicationDidEnterBackground(app)
    }
    
    @objc fileprivate func applicationWillTerminate(_ app: UIApplication) {
        Fenrir.instance.dispatchEventsIfNeeded(ignoreStackAmount: true)
        self.applicationWillTerminate(app)
    }
}
