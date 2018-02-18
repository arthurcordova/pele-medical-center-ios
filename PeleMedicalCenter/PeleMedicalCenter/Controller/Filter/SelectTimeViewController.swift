//
//  SelectDayViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 05/02/18.
//  Copyright © 2018 Mobway. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SelectTimeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet var collectionView: UICollectionView!
    
    var buttonFromView : UIButton?
    var selected : Any?
    var parentVC : MedicDetailViewController?
    var list : Array<Any> = []
    var filters : FilterModel!
    var date : String!
    var room : Int!
    
    let defaultsFilter = UserDefaults.standard
    let url_times = "\(HTTPUtils.URL_MAIN)/agenda/horarios/"
    
    let cellIdentifier = "cellTime"
    let xibIdentifier = "TimeCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filters = FilterModel(data: defaultsFilter)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        loadFromServer(url: url_times)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 6, height: 45)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! TimeCollectionViewCell

        cell.labelTime?.text = (list[indexPath.row] as! TimeModel).time

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = list[indexPath.row] as! TimeModel
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
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
    
    @IBAction func actionSelectTime(_ sender: Any) {
        self.buttonFromView?.setTitle((selected as! TimeModel).time, for: .normal)
        self.parentVC?.timeSelected = selected as! TimeModel
        self.performSegue(withIdentifier: "unwindSegueTime", sender: self)
    }
    
    func loadFromServer(url : String) {
        //{filial}/{date}/{room}
        let dtStr = date?.replacingOccurrences(of: "/", with: "-", options: .literal, range: nil)
        let urlMain = "\(url)\(filters.cityID ?? 0)/\(dtStr ?? "")/\(room ?? 0)"
        
        Alamofire.request(urlMain).responseJSON { response in
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
                                self.list.append(TimeModel(json: json))
                                
                            }
                        }
                    }
                }
            }
            self.collectionView.reloadData();
        }
    }
    
}

