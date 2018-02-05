//
//  NotificationTableViewCell.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 04/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet var labelTitle: UILabel!
    
    @IBOutlet var labelMessage: UILabel!
    
    @IBOutlet var labelDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
