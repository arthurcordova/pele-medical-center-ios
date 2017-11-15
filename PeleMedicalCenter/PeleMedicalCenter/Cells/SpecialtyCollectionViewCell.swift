//
//  SpecialtyCollectionViewCell.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 14/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class SpecialtyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var name: UILabel!
    @IBOutlet var imgBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBackground.layer.cornerRadius = 15
    }

}
