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
    override func viewDidLoad() {
        super.viewDidLoad()
        button.fenrirTag = "buttonzito"
        celly.fenrirTag = "celulita"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Fenrir.instance.registerFlow(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("opa")
    }*/
    
}
