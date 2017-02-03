//
//  FenrirEventRegistering.swift
//  Fenrir
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

extension Fenrir {
    open func register(touchOn view: FenrirTrackeable) {
        guard view.fenrirTag.isEmpty == false else {
            processUndefinedTouchEvent(usefulData: usefulData(forView: view))
            return
        }
        processTouchEvent(tag: view.fenrirTag)
    }
    
    fileprivate func usefulData(forView view: Any) -> String {
        if let button = view as? UIButton {
            if let buttonText = button.titleLabel?.text {
                return "Button Title: \(buttonText)"
            } else if let _ = button.imageView?.image {
                return "Button has an background image"
            }
        }
        if let _ = view as? UITableViewCell {
            return "It's a table cell"
        }
        if let _ = view as? UIView {
            return "It's a tap gestured view"
        }
        return "None"
    }
    
    fileprivate func processUndefinedTouchEvent(usefulData: String) {
        sendEvent(tag: "View without a fenrirTag (Useful data: \(usefulData))", type: .touch)
        log("Touched view with an undefined tag! (Useful data: \(usefulData))")
    }
    
    fileprivate func processTouchEvent(tag: String) {
        sendEvent(tag: tag, type: .touch)
        log("Touched view with tag \(tag)")
    }
}

//MARK: UIButtons (and nav bar buttons)
extension Fenrir {
    @objc func touched(button: UIButton) {
        guard isTracking else {
            return
        }
        register(touchOn: button)
    }
}

//MARK: UITableViewCell
extension Fenrir {
    @objc func touched(cell: UITableViewCell) {
        guard isTracking else {
            return
        }
        register(touchOn: cell)
    }
}

//MARK: UITapGestureRecognized Views
extension Fenrir {
    @objc func touched(gestureView: UIView) {
        guard isTracking else {
            return
        }
        register(touchOn: gestureView)
    }
}
