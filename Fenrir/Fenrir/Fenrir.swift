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
    
    var automatic: Bool = false
    
    open static let instance = Fenrir()
    
    private override init() {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) else {
                self.automatic = false
                return
        }
        let plistValue = dict["fenrirAutoMode"] as? Bool ?? false
        self.automatic = plistValue
    }
    
    open var isTracking: Bool = false
    open var debugMode: Bool = false
    open var stackAmount: Int? = 1
    open var eventHandler: (([String:Any]) -> Void)?
    
    var storedEvents: [[String: Any]] = []
    var currentScreen: String?
    
}
