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
    
    var uuid : Int!
    var name : String!
    var gender : String!
    var specialty : String!
    var specialtyID : Int!
    var clinical : String!
    var acceptInsurance : Bool!
    var roomID : Int!
    var arriveOrder : Bool!
    var nextFreeSchedule : String!
    
    required init?(json: Dictionary<String, AnyObject?>) {
        if let uuid = json["codfunc"] as? Int{
            self.uuid = uuid
        }
        if let name = json["nome"] as? String{
            self.name = name
        }
        if let gender = json["sexo"] as? String{
            self.gender = gender
        }
        if let specialty = json["especialidade"] as? String{
            self.specialty = specialty
        }
        if let specialtyID = json["idEspecialidade"] as? Int{
            self.specialtyID = specialtyID
        }
        if let clinical = json["clinica"] as? String{
            self.clinical = clinical
        }
        if let acceptInsurance = json["aceitaPlano"] as? Bool{
            self.acceptInsurance = acceptInsurance
        }
        if let roomID = json["codSala"] as? Int{
            self.roomID = roomID
        }
        if let arriveOrder = json["ordemChegada"] as? Bool{
            self.arriveOrder = arriveOrder
        }
        if let nextFreeSchedule = json["nextFreeSchedule"] as? String{
            self.nextFreeSchedule = nextFreeSchedule
        }
    }
    
    override init() {
        super.init()
    }
    
    func formatDate(date: String) -> String!{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let date: Date? = dateFormatterGet.date(from: date)
        print(dateFormatter.string(from: date!))
        return dateFormatter.string(from: date!)
    }

}
