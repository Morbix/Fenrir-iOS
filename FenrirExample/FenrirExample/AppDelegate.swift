//
//  AppDelegate.swift
//  FenrirExample
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fenrir.instance.isTracking = true
        Fenrir.instance.debugMode = true
        Fenrir.instance.stackAmount = 3
        Fenrir.instance.eventHandler = { event in
            print("new event")
            print(event)
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        Fenrir.instance.applicationDidEnterBackground()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Fenrir.instance.applicationWillTerminate()
    }

}
