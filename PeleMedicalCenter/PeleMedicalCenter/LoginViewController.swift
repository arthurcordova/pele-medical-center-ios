//
//  LoginViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 06/12/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var inputLoginEmail: UITextField!
    @IBOutlet var inputLoginPwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputLoginEmail.delegate = self
        inputLoginPwd.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == inputLoginEmail){
            textField.resignFirstResponder()
            inputLoginPwd.becomeFirstResponder()
        } else if (textField == inputLoginPwd) {

            doLogin(email: inputLoginEmail.text!, pwd: inputLoginPwd.text!)
            
        }
        return true;
    }
    @IBAction func actionLogin(_ sender: Any) {
        doLogin(email: inputLoginEmail.text!, pwd: inputLoginPwd.text!)
    }
    
    func doLogin(email:String, pwd: String) {
        
        let parameters: [String: String] = [
            "email" : email as String,
            "senha" : pwd as String,
        ]
        
        Alamofire.request("http://www2.beautyclinic.com.br/clickwebservice/servidor/pelews/paciente/login", method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("JSON: \(String(describing: response.result.value))") // response serialization result
            
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                let patient = PatientModel(json: swiftyJsonVar)
                let dialog = DialogUtils.init(controller: self)
                
                dialog.showAlert(title: "Cliente \(patient.id)", message: patient.name, buttonTitle: "Fechar", isAlert:true)
                
              
            }
        }
    }

}
