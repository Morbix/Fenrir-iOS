//
//  Log.swift
//  Pato
//
//  Created by Bruno Rocha on 2/2/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension Pato {
    func log(_ text: String) {
        guard debugMode else {
            return
        }
        print("PATO: " + text)
    }
}
