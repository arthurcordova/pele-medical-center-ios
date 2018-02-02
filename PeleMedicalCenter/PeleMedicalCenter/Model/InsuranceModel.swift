//
//  InsuranceModel.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 02/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import Foundation

class InsuranceModel : NSObject {
    
    var uuid : Int!
    var branch : Int!
    var name : String!
    var authorization : Bool!

    required init?(json: Dictionary<String, AnyObject?>) {
        if let uuid = json["id"] as? Int {
            self.uuid = uuid
        }
        if let branch = json["codFilial"] as? Int {
            self.branch = branch
        }
        if let name = json["descricao"] as? String {
            self.name = name
        }
        if let authorization = json["autorizacao"] as? Bool {
            self.authorization = authorization
        }
    }
    
    override init() {
        super.init()
    }
    
}
