//
//  FirstViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 03/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class MedicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var fruits:[String] = []
    
    let cellIdentifier = "cellMedic"
    let xibIdentifier = "MedicTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fruits = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Pear", "Kiwi", "Strawberry", "Mango", "Walnut", "Apricot", "Tomato", "Almond", "Date", "Melon", "Water Melon", "Lemon", "Coconut", "Fig", "Passionfruit", "Star Fruit", "Clementin", "Citron", "Cherry", "Cranberry"]
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 81

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MedicTableViewCell
        
        // Fetch Fruit
        let fruit = fruits[indexPath.row]

        cell.name?.text = fruit
        
        let imageHeight = cell.avatar?.frame.height;
        cell.avatar?.layer.borderWidth = 0.5
        cell.avatar?.layer.masksToBounds = false
        cell.avatar?.layer.borderColor = UIColor.lightGray.cgColor
        cell.avatar?.layer.cornerRadius = (imageHeight!)/2
        cell.avatar?.clipsToBounds = true
       
        
        // Configure Cell
//        cell.textLabel?.text = fruit
        
        return cell
    }

}
