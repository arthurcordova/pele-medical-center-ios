//
//  SecondViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 03/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import CoreData

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var topHeader: NSLayoutConstraint!
    
    var schedules:[ScheduleModel] = []
    var selectedSchedule: ScheduleModel?
    
    let cellIdentifier = "cellSchedule"
    let xibIdentifier = "ScheduleTableViewCell"
    let segueDetail = "segue_schedule_detail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        
        
        
//        Alamofire.request(.GET, "https://us-central1-scheduling-tracker.cloudfunctions.net/getPhysicians")
//            .response { request, response, data, error in
//                print(request)
//                print(response)
//                print(error)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        schedules.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Schedule")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let schedule = ScheduleModel()
                let patient = PatientModel()
                let physician = PhysicianModel()
                
                schedule.date = data.value(forKey: "schedule_date") as! String
                schedule.time?.time = data.value(forKey: "schedule_time") as! String
                schedule.payment = data.value(forKey: "schedule_payment") as! String
                
                patient.name = data.value(forKey: "patient_name") as! String
                
                physician.name = data.value(forKey: "physician_name") as! String
                physician.specialty = data.value(forKey: "physician_specialty") as! String
                
                schedule.patient = patient
                schedule.physician = physician
                
                schedules.append(schedule)
                
                self.tableView.reloadData()
            }
            
        } catch {
            print("Failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 81
        tableView.separatorStyle = .none
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ScheduleTableViewCell
        

        let schedule = schedules[indexPath.row]
        
        cell.labelPatientName.text = schedule.patient?.name
        cell.labelTime.text = schedule.time?.time
        cell.labelPhysicianName.text = schedule.physician?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedSchedule = schedules[indexPath.item]
        self.performSegue(withIdentifier: segueDetail, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == segueDetail) {
            let controller = segue.destination as! ScheduleFinalDetailsViewController
            controller.schedule = selectedSchedule
        }
    }
    
}

