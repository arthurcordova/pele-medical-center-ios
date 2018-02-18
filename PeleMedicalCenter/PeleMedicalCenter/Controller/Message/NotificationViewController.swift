//
//  NotificationViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 04/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var notifications : Array<NotificationModel> = []
    var selectedNotification : NotificationModel?
    var filter : FilterModel!
    
    let cellIdentifier = "cellNotification"
    let xibIdentifier = "NotificationTableViewCell"
    let defaults = UserDefaults.standard
    let url_notifications = "\(HTTPUtils.URL_MAIN)/messages/getmessages"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        loadData(url: url_notifications)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 81
        tableView.indicatorStyle = .white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NotificationTableViewCell
        
        let notification = notifications[indexPath.row]
        cell.labelTitle?.text = notification.title
        cell.labelMessage?.text = notification.message
        cell.labelDate?.text = notification.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNotification = notifications[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        showActions()
    }
    
    func showActions() {
        let optionMenu = UIAlertController(title: nil, message: "Ações", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Marcar como lida", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Deleted")
        })
        let saveAction = UIAlertAction(title: "Apagar", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Saved")
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
   
    }
    
    
    func loadData(url : String) {
        self.notifications.removeAll()
        
        let parameters: [String: String] = [
//            "codCliente" : defaults.string(forKey: "patient_id"),
            "codCliente" : "20591",
            "status" : "T"
        ]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            print("JSON: \(String(describing: response.result.value))") // response serialization result
            
            if let data = response.result.value{
                
                if  (data as? [[String : AnyObject]]) != nil{
                    
                    if let dictionaryArray = data as? Array<Dictionary<String, AnyObject?>> {
                        if dictionaryArray.count > 0 {
                            
                            for i in 0..<dictionaryArray.count{
                                let json = dictionaryArray[i]
                                let notification = NotificationModel(json: json)
                                self.notifications.append(notification!)
                            }
                            
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
}

