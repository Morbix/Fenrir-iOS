//
//  ViewController.swift
//  FenrirExample
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var celly: UITableViewCell!
    @IBOutlet weak var itemButton: UIBarButtonItem!
    @IBOutlet weak var greenView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        button.fenrirTag = "aButton"
        celly.fenrirTag = "clickableCell"
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.gestureAction))
        greenView.fenrirTag = "greenView"
        greenView.addGestureRecognizer(gesture)
        button.addTarget(self, action: #selector(self.buttonAction(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Fenrir.instance.registerFlow(self)
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        print("touched that button!")
    }
    
    func gestureAction() {
        print("Green view touched original method")
    }
    
}
