//
//  DesignableButton.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 16/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0  {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
