//
//  MedicTableViewCell.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 04/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class MedicTableViewCell: UITableViewCell {

    @IBOutlet var avatar: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var specialty: UILabel!
    @IBOutlet var crmID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
