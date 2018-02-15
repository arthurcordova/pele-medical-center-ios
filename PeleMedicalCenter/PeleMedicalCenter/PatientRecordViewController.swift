//
//  PatientRecordViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 15/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import CoreData

class PatientRecordViewController: UIViewController {

    @IBOutlet var inputName: UITextField!
    @IBOutlet var inputGender: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePatient(_ sender: Any) {
        
    }
    
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
  
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
