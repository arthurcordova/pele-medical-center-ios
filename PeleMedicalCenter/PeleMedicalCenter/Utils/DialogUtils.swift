//
//  DialogUtils.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 26/12/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class DialogUtils {
    
    var viewController : UIViewController!
    
    init(controller: UIViewController) {
        self.viewController = controller
    }
    
    func showAlert(title: String, message: String, buttonTitle: String, isAlert: Bool) -> Void {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        if (isAlert) {
            alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        }
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.destructive, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
