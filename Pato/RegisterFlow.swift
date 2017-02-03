//
//  RegisterFlow.swift
//  Pato
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension Pato {
    func registerFlow(_ object: Any) {
        let `class` = String(describing: type(of:object))
        guard currentScreen != `class` else {
            return
        }
        log("Flowed to \(`class`)")
        sendEvent(tag: `class`, type: .flow)
        currentScreen = `class`
    }
}
