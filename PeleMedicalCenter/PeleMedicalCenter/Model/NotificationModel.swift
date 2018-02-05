//
//  NotificationModel.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 04/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import Foundation

class NotificationModel : NSObject {
    
    var uuid : Int!
    var title : String!
    var message : String!
    var date : String!
    
    required init?(json: Dictionary<String, AnyObject?>) {
        if let uuid = json["id"] as? Int {
            self.uuid = uuid
        }
        if let title = json["titulo"] as? String {
            self.title = title
        }
        if let message = json["mensagem"] as? String {
            self.message = message
        }
        if let date = json["data"] as? String {
            self.date = date
        }
    }
    
    override init() {
        super.init()
    }
    
}
