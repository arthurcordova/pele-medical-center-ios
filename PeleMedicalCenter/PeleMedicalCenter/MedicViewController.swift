//
//  FirstViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 03/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import Alamofire

class MedicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var physicians:[PhysicianModel] = []
    var selectedPhysician : PhysicianModel?
    
    let cellIdentifier = "cellMedic"
    let xibIdentifier = "MedicTableViewCell"
    let segueDetail = "segue_medic_detail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
       
        Alamofire.request("http://www2.beautyclinic.com.br/clinwebservice/servidor/pelews/medicos/getmedicos/3").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        
        
        //MOCK
        let p1 = PhysicianModel()
        p1.name = "Dr. Arthur Cordova Stapassoli"
        p1.gender = "Male"
        p1.specialty = "Cardiologista"
        p1.crm = "736254/SC"
        physicians.append(p1)
        
        let p2 = PhysicianModel()
        p2.name = "Dr. Francisco Nonaka"
        p2.gender = "Male"
        p2.specialty = "Clinico Geral"
        p2.crm = "897678/SP"
        physicians.append(p2)
        
        let p3 = PhysicianModel()
        p3.name = "Dr. Matheus Nonaka"
        p3.gender = "Male"
        p3.specialty = "Pediatra"
        p3.crm = "987544/SC"
        physicians.append(p3)
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 81
        tableView.indicatorStyle = .white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return physicians.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MedicTableViewCell
        
        let physician = physicians[indexPath.row]

        cell.name?.text = physician.name
        cell.specialty?.text = physician.specialty
        cell.crmID?.text = physician.crm
        
        let imageHeight = cell.avatar?.frame.height;
        cell.avatar?.layer.borderWidth = 0.5
        cell.avatar?.layer.masksToBounds = false
        cell.avatar?.layer.borderColor = UIColor.lightGray.cgColor
        cell.avatar?.layer.cornerRadius = (imageHeight!)/2
        cell.avatar?.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPhysician = physicians[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        self.performSegue(withIdentifier: segueDetail, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == segueDetail) {
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! MedicDetailViewController
            controller.physician = selectedPhysician
        }
    }
    
}
