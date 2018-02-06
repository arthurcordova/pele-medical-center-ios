//
//  SelectArriveViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 05/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SelectArriveViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var pickerView: UIPickerView!
    var buttonFromView : UIButton?
    var selected : String?
    var parentVC : MedicDetailViewController?
    var list : Array<String> = []
    var filters : FilterModel!
    var date : String!
    var room : Int!
    
    let defaultsFilter = UserDefaults.standard
    let url_rounds = "\(HTTPUtils.URL_MAIN)/queue/getqueue/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filters = FilterModel(data: defaultsFilter)
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        loadFromServer(url: url_rounds)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var str : String!
        str = list[row]
        
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
    
    @IBAction func selectDay(_ sender: Any) {
        if (list.count > 0 && selected == nil){
            selected = list[0]
        }
        self.buttonFromView?.setTitle(selected, for: .normal)
        self.parentVC?.roundSelected = selected
        self.performSegue(withIdentifier: "unwindSegueRound", sender: self)
    }
    
    func loadFromServer(url : String) {
         //{filial}/{date}/{room}
        let dtStr = date?.replacingOccurrences(of: "/", with: "-", options: .literal, range: nil)
        let urlMain = "\(url)\(filters.cityID ?? 0)/\(dtStr ?? "")/\(room ?? 0)"
        
        Alamofire.request(urlMain).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("JSON: \(String(describing: response.result.value))") // response serialization result
            
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                let order = ArriveOrderModel(json: swiftyJsonVar)
                if (order?.roundNameOne != nil) {
                    self.list.append((order?.roundNameOne)!)
                }
                if (order?.roundNameOne != nil) {
                    self.list.append((order?.roundNameTwo)!)
                }
                
            }
            self.pickerView.reloadAllComponents();
        }
    }
    
}

