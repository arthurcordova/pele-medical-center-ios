//
//  PlaceViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 24/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import Alamofire

class PlaceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var pickerView: UIPickerView!
    
    var buttonFromView : UIButton?
    var places : Array<String> = []
    var selected : Any?
    var list : Array<Any> = []
    var whatIs : String?
    var parentVC : FilterViewController?
    
    let url_cities = "\(HTTPUtils.URL_MAIN)/general/getcities"
    let url_clinic = "\(HTTPUtils.URL_MAIN)/general/getcities"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        loadFromServer(url: url_cities)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var str : String!
        if (whatIs == "city") {
            str = (list[row] as! CityModel).name
        }
        
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
        if (whatIs == "city") {
            if (selected == nil){
                selected = list[0]
            }
            let city = selected as! CityModel
            self.buttonFromView?.setTitle(city.name, for: .normal)
            self.parentVC?.loadSpecialties(cityID: city.uuid)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func loadFromServer(url : String) {
        Alamofire.request(url).responseJSON { response in
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
                                
                                if (url == self.self.url_cities) {
                                    self.whatIs = "city"
                                    let city = CityModel(json: json)
                                    self.list.append(city)
                                }
                            }
                        }
                    }
                }
            }
            self.pickerView.reloadAllComponents();
        }
    }
    
}
