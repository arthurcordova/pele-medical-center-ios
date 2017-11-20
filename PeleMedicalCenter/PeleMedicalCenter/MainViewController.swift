//
//  MainViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 20/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let index = StateMainView.getViewIndex()
        if (index > 0) {
            self.selectedIndex = index
            StateMainView.setViewIndex(index: 0)
        }
    }
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        let index = StateMainView.getViewIndex()
//        if (index > 0) {
//            self.selectedIndex = index
//            StateMainView.setViewIndex(index: 0)
//        }
//    }

}
