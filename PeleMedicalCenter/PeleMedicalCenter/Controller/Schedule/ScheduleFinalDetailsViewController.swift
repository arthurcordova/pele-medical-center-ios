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
import SwiftyJSON

class ScheduleFinalDetailsViewController: UIViewController {

    @IBOutlet var labelPhysicianName: UILabel!
    @IBOutlet var labelPhysicianSpecialty: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelTime: UILabel!
    @IBOutlet var labelPatientName: UILabel!
    @IBOutlet var labelPayment: UILabel!
    @IBOutlet var viewPayment: UIView!
    
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
        labelPatientName.text = schedule?.patient?.name
        
        if (schedule?.time != nil) {
            labelTime.text = schedule?.time?.time
        } else {
            labelTime.text = schedule?.round
        }
        
        if (schedule?.payment != "") {
            labelPayment.text = schedule?.payment
            viewPayment.alpha = 1
        }
        
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
        
    }
    
    @IBAction func actionClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        let alert = UIAlertController(title: "Cancelar agendamento", message: "Todos os dados do agendamento serão perdidos. Deseja cancelar o agendamento", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Não", style: UIAlertActionStyle.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Sim", style: UIAlertActionStyle.default, handler: {
            (alert: UIAlertAction!) in
            StateMainView.setViewIndex(index: 0)
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveSchedule(url: String) {
        let dtStr = schedule?.date.replacingOccurrences(of: "/", with: "-", options: .literal, range: nil)
        var roundStr : String!
        if (schedule?.round == "Manhã") {
            roundStr = "1"
        } else if (schedule?.round == "Tarde"){
            roundStr = "2"
        } else {
            roundStr = "0"
        }
        
        var codAgenda : Int!
        if (schedule?.time != nil) {
            codAgenda = (schedule?.time!.uuid)!
        } else {
            codAgenda = 0
        }
        
        let parameters: [String: Any] = [
                "codAgenda" : codAgenda,
                "codProcedimento": (filters?.consultTypeID)!,
                "codCliente": (schedule?.patient?.id)!,
                "turno": roundStr,
                "data": dtStr as! String
            ]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("JSON: \(String(describing: response.result.value))") // response serialization result

            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                let message = ResponseMessageModel(json: swiftyJsonVar)
                
                let alert = UIAlertController(title: "Agendamento", message: (message?.message)!, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {
                    (alert: UIAlertAction!) in
                    StateMainView.setViewIndex(index: 1)
                    self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
           
        }
    }
 
}
