//
//  TimeModel.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 06/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import Foundation

class TimeModel : NSObject {
    
    var uuid : Int!
    var roomID : Int!
    var time : String!
    
    required init?(json: Dictionary<String, AnyObject?>) {
        if let uuid = json["id"] as? Int {
            self.uuid = uuid
        }
        if let roomID = json["codSala"] as? Int {
            self.roomID = roomID
        }
        if let time = json["horarioInicial"] as? String {
            let index = time.index(time.startIndex, offsetBy: 5)
            self.time = time.substring(to: index)
        }
    }
    
    override init() {
        super.init()
    }
    
}
