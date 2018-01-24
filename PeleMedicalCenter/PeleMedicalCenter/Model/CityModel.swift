//
//  CityModel.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 24/01/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import Foundation

class CityModel : NSObject {
    
    var uuid : Int!
    var name : String!
    
    required init?(json: Dictionary<String, AnyObject?>) {
        if let uuid = json["codigo"] as? Int {
            self.uuid = uuid
        }
        if let name = json["descricao"] as? String {
            self.name = name
        }
    }
    
    override init() {
        super.init()
    }
    
}
