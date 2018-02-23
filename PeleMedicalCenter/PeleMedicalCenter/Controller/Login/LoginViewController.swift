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
    
    let segueLoginOK = "segue_login_ok"
    let defaultsUser = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputLoginEmail.delegate = self
        inputLoginPwd.delegate = self
    }
    
    func checkLogin(){
        let patientID = defaultsUser.integer(forKey: "patient_id")
        if (patientID > 0) {
            self.performSegue(withIdentifier: self.segueLoginOK, sender: nil)
        }
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
        if (inputLoginEmail.text != "" && inputLoginPwd.text != "") {
            doLogin(email: inputLoginEmail.text!, pwd: inputLoginPwd.text!)
        } else {
            let dialog = DialogUtils.init(controller: self)
            dialog.showAlert(title: "Erro", message: "Por favor, informe todos os campos para continuar.", buttonTitle: "Fechar", isAlert: true)
        }
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
                print(swiftyJsonVar)
                let patient = PatientModel(json: swiftyJsonVar)
               
                if (patient.id != nil) {
                    self.defaultsUser.set(patient.id, forKey: "patient_id")
                    self.defaultsUser.set(email, forKey: "patient_email")
                    self.defaultsUser.set(patient.name, forKey: "patient_name")
                    self.defaultsUser.synchronize()
                    
                    self.performSegue(withIdentifier: self.segueLoginOK, sender: nil)
                } else {
                    let dialog = DialogUtils.init(controller: self)
                    dialog.showAlert(title: "Erro", message: "Usuário ou senha inválido.", buttonTitle: "Fechar", isAlert: true)
                    
                }
            }
        }
    }

}
