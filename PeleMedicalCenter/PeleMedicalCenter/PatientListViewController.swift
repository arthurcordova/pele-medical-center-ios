//
//  PatientListViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 15/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class PatientListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonNext: UIBarButtonItem!
    
    var patients:[PatientModel] = []
    var selectedPatient: PatientModel?
    var schedule: ScheduleModel?
    var filters : FilterModel?

    let userSaved = UserDefaults.standard
    let url_dependents = "\(HTTPUtils.URL_MAIN)/paciente/getdependents/"
    let cellIdentifier = "cellPatient"
    let xibIdentifier = "PatientTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 81
        tableView.indicatorStyle = .white
        
        filters = FilterModel(data: userSaved)
        
        loadFromServer(url: url_dependents)
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
    @IBAction func actionNextStep(_ sender: Any) {
        if (selectedPatient != nil){
            if (filters?.consultTypeName == "CONSULTA PARTICULAR") {
                performSegue(withIdentifier: "segue_next_final", sender: self)
            } else {
                performSegue(withIdentifier: "segue_next_payment", sender: self)
            }
        }
        
    }
    
    func loadFromServer(url : String) {
        
        Alamofire.request("\(url)\(userSaved.integer(forKey: "patient_id") )").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("JSON: \(String(describing: response.result.value))") // response serialization result
            
            if let data = response.result.value{
                if  (data as? [[String : AnyObject]]) != nil{
                    
                    if let dictionaryArray = data as? Array<Dictionary<String, AnyObject?>> {
                        if dictionaryArray.count > 0 {
                            
                            for i in 0..<dictionaryArray.count{
                                
                                let json = dictionaryArray[i]
                                self.patients.append(PatientModel(json: json))
                                
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
   
}
