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
    
    var payments:[String] = []
    var selectedPayment = ""
    
    let cellIdentifier = "cellPayment"
    let xibIdentifier = "PaymentTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        
        payments = ["Cartão", "Dinheiro", "Plano de saúde"]
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 42
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
   
}
