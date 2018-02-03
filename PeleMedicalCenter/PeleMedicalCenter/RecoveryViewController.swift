//
//  RecoveryViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 03/01/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecoveryViewController: UIViewController {

    @IBOutlet var inputEmail: UITextField!
    
    let url_recover = "\(HTTPUtils.URL_MAIN)/paciente/passrecover/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func actionRecover(_ sender: Any) {
        if (inputEmail.text != "") {
            recoverPwd(url: url_recover, email: inputEmail.text!)
        } else {
            let dialog = DialogUtils.init(controller: self)
            dialog.showAlert(title: "Recuperação de senha", message: "Por favor, insira um e-mail válido.", buttonTitle: "Fechar", isAlert:true)
        }
    }
    
    private func recoverPwd(url: String, email : String){
        Alamofire.request("\(url)\(email)").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("JSON: \(String(describing: response.result.value))") // response serialization result
            
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
                print(swiftyJsonVar)
//                let patient = PatientModel(json: swiftyJsonVar)
//                let dialog = DialogUtils.init(controller: self)
//
//                self.defaultsUser.set(patient.id, forKey: "patient_id")
//                self.defaultsUser.set(email, forKey: "patient_email")
//                self.defaultsUser.set(patient.name, forKey: "patient_name")
//                self.defaultsUser.synchronize()
//
//                self.performSegue(withIdentifier: self.segueLoginOK, sender: nil)
                let dialog = DialogUtils.init(controller: self)
                dialog.showAlert(title: "Recuperação de senha", message: "Sucesso! Enviamos um e-mail com o proceimento para recuperação de senha", buttonTitle: "Fechar", isAlert:true)
            }
        }
    }
    
    
}
