//
//  PlaceViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 24/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var pickerView: UIPickerView!
    
    var buttonFromView : UIButton?
    var places : Array<String> = []
    var selected : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        places.append("Fortaleza")
        places.append("Maceió")
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return places[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = places[row]
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
        if (selected != nil){
            buttonFromView?.setTitle(selected, for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}
