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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Fenrir.instance.registerFlow(self)
    }
    
    func gestureAction() {
        print("Green view touched original method")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("-didSelectRowAt-")
    }
    
}
