//
//  PlaceViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 24/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import Alamofire

class ConsultTypedViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    
    var buttonFromView : UIButton?
    var buttonFromViewInsurance : UIButton?
    var places : Array<String> = []
    var selected : Any?
    var list : Array<Any> = []
    var whatIs : String?
    var parentVC : FilterViewController?
    var filters : FilterModel!
    
    let url_consult_type = "\(HTTPUtils.URL_MAIN)/procedimentos/getprocedimentos/"
    
    let defaultsFilter = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        filters = FilterModel(data: defaultsFilter)
        
        loadFromServer(url: url_consult_type)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var str : String!
        str = (list[row] as! ConsultTypeModel).name
        
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
        let consult = selected as? ConsultTypeModel
        if (consult != nil){
            self.defaultsFilter.setValue(consult?.uuid, forKey: "consult_type_id")
            self.defaultsFilter.setValue(consult?.name, forKey: "consult_type_name")
            self.defaultsFilter.synchronize()
            self.buttonFromView?.setTitle(consult?.name, for: .normal)
            
            if (consult?.name.contains("PARTICULAR"))! {
                self.defaultsFilter.set(nil, forKey: "insurance_id")
                self.defaultsFilter.set(nil, forKey: "insurance_name")
                self.defaultsFilter.synchronize()
                self.buttonFromViewInsurance?.setTitle("", for: .normal)
                self.buttonFromViewInsurance?.isEnabled = false;
                
            } else {
                self.buttonFromViewInsurance?.isEnabled = true;
            }
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    func loadFromServer(url : String) {
        
        Alamofire.request("\(url)\(filters.cityID ?? 0)").responseJSON { response in
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
                                let consult = ConsultTypeModel(json: json)
                                self.list.append(consult)
                            }
                        }
                    }
                }
            }
            self.pickerView.reloadAllComponents();
        }
    }
    
}


