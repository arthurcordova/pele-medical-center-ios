//
//  ResponseMessageModel.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 06/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResponseMessageModel : NSObject {
    
    var uuid : Int!
    var message : String!
    
    required init?(json: JSON) {
        if let uuid = json["codigo"].int {
            self.uuid = uuid
        }
        if let message = json["mensagem"].string {
            self.message = message
        }
    }
    
    override init() {
        super.init()
    }
    
}
