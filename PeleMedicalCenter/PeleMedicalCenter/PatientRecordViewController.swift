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
    @IBOutlet var inputBirth: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePatient(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Patient", in: context)
        let newPatient = NSManagedObject(entity: entity!, insertInto: context)
        
        newPatient.setValue(inputName.text, forKey: "name")
        newPatient.setValue(inputGender.text, forKey: "gender")
        
        do {
            try context.save()
            self.dismiss(animated: true, completion: nil)
            
            performSegueToReturnBack()
        } catch {
            print("Failed saving")
        }
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
