//
//  ArriveOrderModel.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 05/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import Foundation
import SwiftyJSON

class ArriveOrderModel : NSObject {
    
    var uuid : Int!
    var vacanciesFirstRound : Int!
    var vacanciesSecondRound : Int!
    var roundNameOne : String!
    var roundNameTwo : String!
    
    required init?(json: JSON) {
        if let uuid = json["idAgenda"].int {
            self.uuid = uuid
        }
        if let vacanciesFirstRound = json["vagasPrimeiro"].int {
            self.vacanciesFirstRound = vacanciesFirstRound
        }
        if let vacanciesSecondRound = json["vagasSegundo"].int {
            self.vacanciesSecondRound = vacanciesSecondRound
        }
        if (self.vacanciesFirstRound > 0) {
            self.roundNameOne = "Manhã"
        }
       
        if (self.vacanciesSecondRound > 0) {
            self.roundNameTwo = "Tarde"
        }
    }
    
    override init() {
        super.init()
    }
    
}
