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
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.actionSheet)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        return true;
    }

    func doLogin(email:String, pwd: String) {
        
        let parameters: [String: AnyObject] = [
            "email" : email as AnyObject,
            "senha" : pwd as AnyObject,
        ]
        
        Alamofire.request("http://www2.beautyclinic.com.br/clinwebservice/servidor/pelews/paciente/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("JSON: \(String(describing: response.result.value))") // response serialization result
            
            if let data = response.result.value{
                print(data)
            }
        }
    }

}
