//
//  SecondViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 03/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var topHeader: NSLayoutConstraint!
    
    var schedules:[ScheduleModel] = []
    var selectedSchedule: ScheduleModel?
    
    let cellIdentifier = "cellSchedule"
    let xibIdentifier = "ScheduleTableViewCell"
    let segueDetail = "segue_schedule_detail"
    let defaults = UserDefaults.standard
    let url_schedules = "\(HTTPUtils.URL_MAIN)/agenda/getagendamentos/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
     
        loadData(url: url_schedules)
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
    
    func loadData(url : String) {
        self.schedules.removeAll()
        
        Alamofire.request("\(url)\(defaults.integer(forKey: "patient_id"))").responseJSON { response in
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
//                                let schedule = ScheduleModel(json: json)
//                                self.schedules.append(schedule)
                            }
                            
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
}

