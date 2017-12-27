//
//  PatientListViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 15/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import CoreData

class PatientListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonNext: UIBarButtonItem!
    
    var patients:[PatientModel] = []
    var selectedPatient: PatientModel?
    var schedule: ScheduleModel?
    let cellIdentifier = "cellPatient"
    let xibIdentifier = "PatientTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 81
        tableView.indicatorStyle = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        patients.removeAll()
        buttonNext.isEnabled = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Patient")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let patient = PatientModel()
                patient.name = data.value(forKey: "name") as! String
//                patient.gender = data.value(forKey: "gender") as! String
//                patient.birth = data.value(forKey: "birth") as? Date
//
                patients.append(patient)
                self.tableView.reloadData()
            }
            
        } catch {
            print("Failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PatientTableViewCell
        
        let patient = self.patients[indexPath.row]
        
        cell.labelName?.text = patient.name
//        cell.labelGender?.text = patient.gender
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt_BR")
        
//        if (patient.birth != nil){
//            cell.labelBirth?.text = dateFormatter.string(from: (patient.birth)!)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buttonNext.isEnabled = true
        selectedPatient = patients[indexPath.item]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_next_payment") {
            let controller = segue.destination as! PaymentViewController
            schedule?.patient = selectedPatient
            controller.schedule = schedule
        }
    }
   
}
