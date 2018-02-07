//
//  PaymentViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 16/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonSave: UIBarButtonItem!
    
    var schedule: ScheduleModel?
    var payments:[String] = []
    var selectedPayment = ""
    
    let cellIdentifier = "cellPayment"
    let xibIdentifier = "PaymentTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        
        payments = ["Cartão", "Dinheiro"]
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 42
    }

    override func viewDidAppear(_ animated: Bool) {
        buttonSave.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PaymentTableViewCell
        
        let payment = payments[indexPath.row]
        cell.labelPaymentName?.text = payment
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buttonSave.isEnabled = true
        schedule?.payment = payments[indexPath.item]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_final_step") {
            let controller = segue.destination as! ScheduleFinalDetailsViewController
            controller.schedule = schedule
        }
    }
    
}
