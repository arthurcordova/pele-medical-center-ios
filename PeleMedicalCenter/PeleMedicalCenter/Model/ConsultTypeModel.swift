//
//  ConsultTypeModel.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 02/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import Foundation

class ConsultTypeModel : NSObject {
    
    var uuid : Int!
    var name : String!
    
    required init?(json: Dictionary<String, AnyObject?>) {
        if let uuid = json["codProd"] as? Int {
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
