//
//  PatientRecordViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 15/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PatientRecordViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet var inputName: UITextField!
    @IBOutlet var inputGender: UITextField!
    
    let url_create_user = "\(HTTPUtils.URL_MAIN)/paciente/create"
    let userSaved = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputGender.delegate = self
        inputName.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePatient(_ sender: Any) {
        if (inputName.text != "" && inputGender.text != ""){
            createUser(url: url_create_user)
        } else {
            let dialog = DialogUtils.init(controller: self)
            dialog.showAlert(title: "Erro", message: "Por favor informe todos os campos.", buttonTitle: "Fechar", isAlert: true)
        }
    }
    
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
  
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == inputName){
            textField.resignFirstResponder()
            inputGender.becomeFirstResponder()
        } else if (textField == inputGender) {
            savePatient(self)
        }
        return true;
    }
    
    func createUser(url : String) {
        
        let mainPatient = PatientModel()
        mainPatient.id = userSaved.integer(forKey: "patient_id")
        
        let parameters: [String: Any] = [
            "nome" : inputName.text!,
            "email": inputGender.text!,
            "senha": "",
            "codResponsavel": mainPatient.id
        ]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("JSON: \(String(describing: response.result.value))") // response serialization result
            
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                
                self.dismiss(animated: true, completion: nil)
                
//                self.performSegue(withIdentifier: self.segueOKLogin, sender: nil)
                
            } else {
                let dialog = DialogUtils.init(controller: self)
                dialog.showAlert(title: "Erro", message: "\(response.result.description).", buttonTitle: "Fechar", isAlert: true)
            }
        }
    }
}
