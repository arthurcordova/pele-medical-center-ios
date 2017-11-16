//
//  TESTEViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 15/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit

class MedicDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var buttonSchedule: UIBarButtonItem!
    @IBOutlet var noTimeImage: UIImageView!
    @IBOutlet var noTimeLabel: UILabel!
    @IBOutlet var timeIndicator: UIActivityIndicatorView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var labelSelectTime: UILabel!
    @IBOutlet var medicName: UILabel!
    
    var medic = ""
    var fruits:[String] = []
    
    let cellIdentifier = "cellTime"
    let xibIdentifier = "TimeCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.layer.isHidden = true
        
        hideAnim(view: timeIndicator)
        showAnim(view: noTimeImage)
        showAnim(view: noTimeLabel)
        
        
        medicName.text = medic

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.allowsMultipleSelection = false
        collectionView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        fruits = ["14:00", "14:45", "16:00", "17:00", "19:15", "14:00", "14:45", "16:00", "17:00", "19:15", "14:00", "14:45", "16:00", "17:00", "19:15", "14:00", "14:45", "16:00", "17:00", "19:15"]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 6, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! TimeCollectionViewCell
        
        cell.labelTime?.text = fruits[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        buttonSchedule.isEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        buttonSchedule.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        
        buttonSchedule.isEnabled = false
        hideAnim(view: collectionView)
        showAnim(view: timeIndicator)
        
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
    
}
