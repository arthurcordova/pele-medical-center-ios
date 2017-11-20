//
//  StateMainView.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 20/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import Foundation

final class StateMainView {
    // 0-physicians 1-schedules
    internal static var viewIndex = 0
    
    private init() {
        
    }
    
    static func setViewIndex( index:Int) {
        self.viewIndex = index
    }
    
    static func getViewIndex() -> Int {
        return self.viewIndex
    }
}
