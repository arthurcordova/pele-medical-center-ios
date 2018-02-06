//
//  ScheduleFinalDetailsViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 16/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ScheduleFinalDetailsViewController: UIViewController {

    @IBOutlet var labelPhysicianName: UILabel!
    @IBOutlet var labelPhysicianSpecialty: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelTime: UILabel!
    @IBOutlet var labelPatientName: UILabel!
    @IBOutlet var labelPayment: UILabel!
    
    var schedule: ScheduleModel?
    var filters: FilterModel?
    
    let userDefaults = UserDefaults.standard
    let url_schedule = "\(HTTPUtils.URL_MAIN)/agenda/doagendamento"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filters = FilterModel(data: userDefaults)

        labelPhysicianName.text = schedule?.physician?.name
        labelPhysicianSpecialty.text = schedule?.physician?.specialty
        labelDate.text = schedule?.date
        labelTime.text = schedule?.time?.time
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
        
        saveSchedule(url: url_schedule)
        
//        StateMainView.setViewIndex(index: 1)
//
//        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

    }
    
    func saveSchedule(url: String) {
        let parameters: [String: Int] = [
            "codAgenda" : filters.cityID,
            "codProcedimento": filters?.consultTypeID,
            "codCliente": filters.specialtyID,
            "turno": filters.specialtyID,
            "data": filters.specialtyID
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
                                let clinic = ClinicModel(json: json)
                                self.list.append(clinic)
                            }
                        }
                    }
                }
            }
            self.pickerView.reloadAllComponents();
        }
    }
 
}
