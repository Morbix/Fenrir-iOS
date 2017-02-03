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
    open var eventHandler: (([String:Any]) -> Void)?
    
    var storedEvents: [[String: Any]] = []
    var currentScreen: String?
    
}
