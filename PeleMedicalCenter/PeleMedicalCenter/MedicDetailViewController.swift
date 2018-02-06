//
//  TESTEViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 15/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import CoreData

class MedicDetailViewController: UIViewController {

    @IBOutlet var buttonSchedule: UIBarButtonItem!
    @IBOutlet var buttonTimeRound: UIButton!
    @IBOutlet var buttonDate: UIButton!
    @IBOutlet var labelTimeRound: UILabel!
    @IBOutlet var viewWarningRound: UIView!
    @IBOutlet var viewTimeRound: UIView!
    @IBOutlet var medicName: UILabel!
    @IBOutlet var labelSpecialty: UILabel!
    
    var physician : PhysicianModel?
    var schedule: ScheduleModel?
    
    var dateSelected: String?
    var roundSelected: String?
    var timeSelected: TimeModel?
    
    let segueSelectDay = "segue_select_day"
    let segueSelectTime = "segue_select_time"
    let segueSelectRound = "segue_select_round"
    
    let unwindSegueSelectDay = "unwindSegueToMedicDetail"
    let unwindSegueSelectRound = "unwindSegueRound"
    let unwindSegueSelectTime = "unwindSegueTime"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schedule = ScheduleModel()
        schedule?.physician = physician
        
        medicName.text = physician?.name
        labelSpecialty.text = physician?.specialty
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToMedic(unwindSegue: UIStoryboardSegue) {
        print(unwindSegue.identifier ?? "Nenhum segue")
        if (unwindSegue.identifier == unwindSegueSelectDay) {
            if (dateSelected != nil) {
                if (physician?.arriveOrder)! {
                    labelTimeRound.text = "Selecione o turno:"
                    showAnim(view: viewWarningRound)
                }
                showAnim(view: viewTimeRound)
            }
        }
        if (unwindSegue.identifier == unwindSegueSelectRound) {
            if (roundSelected != nil) {
                buttonSchedule.isEnabled = true
            }
        }
        if (unwindSegue.identifier == unwindSegueSelectTime) {
            if (timeSelected != nil) {
                buttonSchedule.isEnabled = true
            }
        }
    }
    
    @IBAction func actionTimerOrRound(_ sender: Any) {
        if (physician?.arriveOrder)! {
            self.performSegue(withIdentifier: segueSelectRound, sender: nil)
        } else {
            self.performSegue(withIdentifier: segueSelectTime, sender: nil)
        }
    }
    
    func hideAnim(view: UIView){
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            view.alpha = 0.0
        }, completion: nil)
    }
    
    func showAnim(view: UIView){
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            view.alpha = 1.0
        }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_next_patient") { // NEXT STEP
            let controller = segue.destination as! PatientListViewController
            schedule?.date = (buttonDate.titleLabel?.text)!
            schedule?.time = timeSelected
            controller.schedule = schedule
            
        } else if (segue.identifier == segueSelectDay) { //SELECT DAY
            let controller = segue.destination as! SelectDayViewController
            controller.buttonFromView = buttonDate
            controller.parentVC = self
            
        } else if (segue.identifier == segueSelectTime) { //SELECT TIME
            let controller = segue.destination as! SelectTimeViewController
            controller.buttonFromView = buttonTimeRound
            controller.parentVC = self
            controller.date = buttonDate.titleLabel?.text
            controller.room = physician?.roomID
            
        } else if (segue.identifier == segueSelectRound) { // SELECT ROUND
            let controller = segue.destination as! SelectArriveViewController
            controller.buttonFromView = buttonTimeRound
            controller.parentVC = self
            controller.date = buttonDate.titleLabel?.text
            controller.room = physician?.roomID
            
        }
        
    }
    
}
