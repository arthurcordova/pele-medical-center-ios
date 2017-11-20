//
//  ScheduleFinalDetailsViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 16/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class ScheduleFinalDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmSchedule(_ sender: Any) {
        StateMainView.setViewIndex(index: 1)
        
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

    }
 
}
