//
//  ProfileViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 03/01/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelEmail: UILabel!
    
    let defaultsUser = UserDefaults.standard
    let segueLogout = "segue_logout"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.text = defaultsUser.string(forKey: "patient_name")
        labelEmail.text = defaultsUser.string(forKey: "patient_email")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionLogout(_ sender: Any) {
        defaultsUser.removeObject(forKey: "patient_id")
        defaultsUser.removeObject(forKey: "patient_name")
        defaultsUser.removeObject(forKey: "patient_email")
        defaultsUser.synchronize()
        
        self.performSegue(withIdentifier: segueLogout, sender: nil)
    }
    
}
