//
//  PlaceViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 24/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import Alamofire

class ClinicViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    
    var buttonFromView : UIButton?
    var places : Array<String> = []
    var selected : Any?
    var list : Array<Any> = []
    var whatIs : String?
    var parentVC : FilterViewController?
    var filters : FilterModel!
    
    let url_clinic = "\(HTTPUtils.URL_MAIN)/general/getclinics"
    
    let defaultsFilter = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        filters = FilterModel(data: defaultsFilter)
        
        loadFromServer(url: url_clinic)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var str : String!
        str = (list[row] as! ClinicModel).name
        
        return str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (list.count > 0){
            selected = list[row]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectedPlace(_ sender: Any) {
       
        if (selected == nil){
            if (list.count > 0){
                selected = list[0]
            }
        }
        let clinic = selected as? ClinicModel
        if (clinic != nil){
            self.defaultsFilter.setValue(clinic?.uuid, forKey: "clinical_id")
            self.defaultsFilter.setValue(clinic?.name, forKey: "clinical_name")
            self.defaultsFilter.synchronize()
            self.buttonFromView?.setTitle(clinic?.name, for: .normal)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func loadFromServer(url : String) {
        
        let parameters: [String: Int] = [
            "codFilial" : filters.cityID,
            "codEspecialidade": filters.specialtyID,
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

