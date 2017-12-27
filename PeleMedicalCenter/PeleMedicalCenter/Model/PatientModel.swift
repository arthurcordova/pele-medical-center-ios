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
    
    init() {
        
    }
    
    init(json: JSON) {
        if let name = json["nome"].string {
            self.name = name
        }
        if let id = json["codcliente"].int {
            self.id = id
        }
    }
    
}
