//
//  Patient.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 15/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import Foundation
import SwiftyJSON

class PatientModel {
    
    var id : Int?
    var name : String = ""
    var email : String?
    
    init() {
        
    }
    
    init(json: JSON) {
        if let name = json["nome"].string {
            self.name = name
        }
        if let id = json["codcliente"].int {
            self.id = id
        }
        if let email = json["email"].string {
            self.email = email
        }
    }
    
    init(json: Dictionary<String, AnyObject?>) {
        if let name = json["nome"] as? String {
            self.name = name
        }
        if let id = json["codcliente"] as? Int {
            self.id = id
        }
        if let email = json["email"] as? String {
            self.email = email
        }
    }
    
}
