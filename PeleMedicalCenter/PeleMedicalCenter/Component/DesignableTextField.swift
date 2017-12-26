//
//  DesignableTextField.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 06/12/17.
//  Copyright © 2017 Mobway. All rights reserved.
//
import UIKit

@IBDesignable class DesignableTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0  {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
