//
//  SignupViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 03/01/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignupViewController: UIViewController {
    
    @IBOutlet var inputName: UITextField!
    @IBOutlet var inputEmail: UITextField!
    @IBOutlet var inputPwd: UITextField!
    
    let segueOKLogin = "segue_sign_in_ok"
    let url_create_user = "\(HTTPUtils.URL_MAIN)/paciente/create"
    let savedUser = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func actionCreate(_ sender: Any) {
        if (inputName.text != "" && inputEmail.text != "" && inputPwd.text != "") {
            createUser(url: url_create_user)
        } else {
            let dialog = DialogUtils.init(controller: self)
            dialog.showAlert(title: "Erro", message: "Por favor, informe todos os campos para continuar.", buttonTitle: "Fechar", isAlert: true)
        }
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func createUser(url : String) {
        
        let parameters: [String: String] = [
            "nome" : inputName.text!,
            "email": inputEmail.text!,
            "senha": inputPwd.text!,
            "codResponsavel": "0"
        ]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("JSON: \(String(describing: response.result.value))") // response serialization result
            
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
                let patient = PatientModel(json: swiftyJsonVar)
               
                self.savedUser.set(patient.id, forKey: "patient_id")
                self.savedUser.set(patient.email, forKey: "patient_email")
                self.savedUser.set(patient.name, forKey: "patient_name")
                self.savedUser.synchronize()
                
                self.performSegue(withIdentifier: self.segueOKLogin, sender: nil)
             
            } else {
                let dialog = DialogUtils.init(controller: self)
                dialog.showAlert(title: "Erro", message: "\(response.result.description).", buttonTitle: "Fechar", isAlert: true)
            }
        }
    }
    
}
