//
//  FilterModel.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 02/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import Foundation

class FilterModel: NSObject {
    
    let uuid : Int = 1
    var specialtyID : Int!
    var insuranceID : Int!
    var clinicalID : Int!
    var cityID : Int!
    var consultTypeID : Int!
    
    var cityName : String!
    var clinicalName : String!
    var consultTypeName : String!
    var insuranceName : String!
    
    init(data: UserDefaults) {
        if let cityID = data.value(forKey: "city_id") as? Int {
            self.cityID = cityID
        }
        if let specialtyID = data.value(forKey: "specialty_id") as? Int {
            self.specialtyID = specialtyID
        }
        if let clinicalID = data.value(forKey: "clinical_id") as? Int {
            self.clinicalID = clinicalID
        }
        if let consultTypeID = data.value(forKey: "consult_type_id") as? Int {
            self.consultTypeID = consultTypeID
        }
        if let insuranceID = data.value(forKey: "insurance_id") as? Int {
            self.insuranceID = insuranceID
        }
        
        
        if let cityName = data.value(forKey: "city_name") as? String {
            self.cityName = cityName
        }
        if let clinicalName = data.value(forKey: "clinical_name") as? String {
            self.clinicalName = clinicalName
        }
        if let consultTypeName = data.value(forKey: "consult_type_name") as? String {
            self.consultTypeName = consultTypeName
        }
        if let insuranceName = data.value(forKey: "insurance_name") as? String {
            self.insuranceName = insuranceName
        }
        
    }
    
    override init() {
        
    }
    
}
