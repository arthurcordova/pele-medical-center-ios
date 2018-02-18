//
//  SelectDayViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 05/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import UIKit

class SelectDayViewController: UIViewController {
    
    @IBOutlet var datePIcker: UIDatePicker!
    
    var buttonFromView : UIButton?
    var selected : Any?
    var parentVC : MedicDetailViewController?
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectDay(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dt = dateFormatter.string(from: datePIcker.date)
        self.buttonFromView?.setTitle(dt, for: .normal)
        self.parentVC?.dateSelected = dt
        self.performSegue(withIdentifier: "unwindSegueToMedicDetail", sender: self)
    }
    
}
