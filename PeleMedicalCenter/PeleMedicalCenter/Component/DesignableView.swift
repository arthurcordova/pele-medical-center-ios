//
//  DesignableView.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 16/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0  {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: CGColor =  UIColor.black.cgColor  {
        didSet {
            self.layer.shadowColor = shadowColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float =  0  {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize =  CGSize.zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat =  0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
}
