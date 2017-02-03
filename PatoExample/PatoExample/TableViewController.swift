//
//  ViewController.swift
//  PatoExample
//
//  Created by Bruno Rocha on 2/3/17.
//  Copyright © 2017 Bruno Rocha. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var celly: UITableViewCell!
    @IBOutlet weak var itemButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        button.patoTag = "buttonzito"
        celly.patoTag = "celulita"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Pato.instance.registerFlow(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("touch!")
    }
}
