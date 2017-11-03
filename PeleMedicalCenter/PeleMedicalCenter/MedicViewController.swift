//
//  FirstViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 03/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class MedicViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}