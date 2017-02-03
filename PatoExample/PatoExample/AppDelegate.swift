//
//  AppDelegate.swift
//  PatoExample
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Pato.instance.isTracking = true
        Pato.instance.debugMode = true
        Pato.instance.stackAmount = 3
        Pato.instance.eventHandler = { event in
            print("new event")
            print(event)
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        Pato.instance.applicationDidEnterBackground()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Pato.instance.applicationWillTerminate()
    }

}
