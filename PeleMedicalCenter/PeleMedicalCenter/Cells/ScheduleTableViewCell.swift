//
//  ScheduleTableViewCell.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 05/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet var dayNumber: UILabel!
    @IBOutlet var dayName: UILabel!
    @IBOutlet var cardContent: UIView!
    @IBOutlet var labelPhysicianName: UILabel!
    @IBOutlet var labelPatientName: UILabel!
    @IBOutlet var labelTime: UILabel!
    
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardContent.layer.cornerRadius = 8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
