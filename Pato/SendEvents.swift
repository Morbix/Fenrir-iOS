//
//  SendEvents.swift
//  Pato
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension Pato {
    func sendEvent(tag: String, type: PatoEventType) {
        let parameters: [String:Any] = {
            var params = [
                "tag": tag,
                "type": type.rawValue,
                "date": Date().string
            ]
            if let screen = currentScreen, type == .touch {
                params["screen"] = screen
            }
            return params
        }()
        storedEvents.append(parameters)
        dispatchEventsIfNeeded()
    }
    
    func dispatchEventsIfNeeded(ignoreStackAmount: Bool = false) {
        guard ignoreStackAmount || (stackAmount != nil && storedEvents.count >= stackAmount!) else {
            return
        }
        for event in storedEvents {
            eventHandler?(event)
            storedEvents.remove(at: 0)
        }
    }
}
