//
//  Physician.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 20/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhysicianModel: NSObject {
    
    var uuid : String!
    var acceptInsurance : String!
    var name : String!
    var specialty : String!
    var gender : String!
    var crm : String!
    
    required init?(json: Dictionary<String, AnyObject?>) {
        if let name = json["nome"] as? String{
            self.name = name
        }
        if let gender = json["sexo"] as? String{
            self.gender = gender
        }
        if let specialty = json["especialidade"] as? String{
            self.specialty = specialty
        }
    }
    
    override init() {
        super.init()
    }

}
