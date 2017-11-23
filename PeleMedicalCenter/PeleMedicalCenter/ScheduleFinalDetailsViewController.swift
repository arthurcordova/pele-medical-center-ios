//
//  ScheduleFinalDetailsViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 16/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import CoreData

class ScheduleFinalDetailsViewController: UIViewController {

    @IBOutlet var labelPhysicianName: UILabel!
    @IBOutlet var labelPhysicianSpecialty: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelTime: UILabel!
    @IBOutlet var labelPatientName: UILabel!
    @IBOutlet var labelPayment: UILabel!
    
    var schedule: ScheduleModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelPhysicianName.text = schedule?.physician?.name
        labelPhysicianSpecialty.text = schedule?.physician?.specialty
        labelDate.text = schedule?.date
        labelTime.text = schedule?.time
        labelPatientName.text = schedule?.patient?.name
        labelPayment.text = schedule?.payment
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmSchedule(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Schedule", in: context)
        let newSchedule = NSManagedObject(entity: entity!, insertInto: context)
        
        newSchedule.setValue(schedule?.date, forKey: "schedule_date")
        newSchedule.setValue(schedule?.time, forKey: "schedule_time")
        newSchedule.setValue(schedule?.payment, forKey: "schedule_payment")
        newSchedule.setValue("A", forKey: "schedule_status")
        newSchedule.setValue(schedule?.physician?.name, forKey: "physician_name")
        newSchedule.setValue(schedule?.physician?.specialty, forKey: "physician_specialty")
        newSchedule.setValue(schedule?.patient?.name, forKey: "patient_name")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        
        StateMainView.setViewIndex(index: 1)
        
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

    }
 
}
