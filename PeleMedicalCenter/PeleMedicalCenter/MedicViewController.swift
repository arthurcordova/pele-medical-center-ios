//
//  FirstViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 03/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class MedicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var physicians : Array<PhysicianModel> = []
    var selectedPhysician : PhysicianModel?
    var filter : FilterModel!
    
    let cellIdentifier = "cellMedic"
    let xibIdentifier = "MedicTableViewCell"
    let segueDetail = "segue_medic_detail"
    let defaults = UserDefaults.standard
    let url_physicians = "\(HTTPUtils.URL_MAIN)/medicos/getdoctors"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
       
        filter = FilterModel(data: defaults)
        
        loadData(url: url_physicians)
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
    
    func loadData(url : String) {
        self.physicians.removeAll()
        
        let parameters: [String: Int] = [
            "codCidade" : filter.cityID == nil ? 0 : filter.cityID,
            "codClinica": filter.clinicalID == nil ? 0 : filter.clinicalID,
            "codEspecialidade": filter.specialtyID == nil ? 0 : filter.specialtyID,
            "tipoConsulta": filter.consultTypeID == nil ? 0 : filter.consultTypeID,
            "codConvenio": filter.insuranceID == nil ? 0 : filter.insuranceID
        ]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
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
                                let physician = PhysicianModel(json: json)
                                self.physicians.append(physician!)
                            }
                            
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
}
