//
//  FilterViewController.swift
//  PeleMedicalCenter
//
//  Created by Arthur on 14/11/17.
//  Copyright © 2017 Mobway. All rights reserved.
//

import UIKit
import Alamofire

class FilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var buttonPlace: UIButton!
    
    let cellIdentifier = "cellSpecialty"
    let xibIdentifier = "SpecialtyCollectionViewCell"
    let segueDropDown = "segue_drop_down"
    let url_specialties = "\(HTTPUtils.URL_MAIN)/especialidade/getespecialidades"
    
    var specialties:[SpecialtyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.allowsMultipleSelection = false
        collectionView.register(UINib(nibName: xibIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
    }
    
    public func loadSpecialties(cityID: Int) {
        if (cityID > 0){
            loadSpecialtiesFromServer(url: url_specialties, uuid: cityID)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specialties.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                      for: indexPath) as! SpecialtyCollectionViewCell
        
        let model = specialties[indexPath.row]
        cell.name?.text = model.name
        cell.contentView.layoutMargins.left = 20
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsAcross: CGFloat = 3
        var widthRemainingForCellContent = collectionView.bounds.width
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let borderSize: CGFloat = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            widthRemainingForCellContent -= borderSize + ((cellsAcross - 1) * flowLayout.minimumInteritemSpacing)
        }
        
        let cellWidth = widthRemainingForCellContent / cellsAcross
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == segueDropDown) {
            let controller = segue.destination as! PlaceViewController
            controller.buttonFromView = buttonPlace
            controller.parentVC = self
        }
    }
   
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadSpecialtiesFromServer(url : String, uuid: Int) {
        let urlWithParameter = "\(url)/\(uuid)"
        Alamofire.request(urlWithParameter).responseJSON { response in
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
                                    let specialty = SpecialtyModel(json: json)
                                    self.specialties.append(specialty!)
                                }
                        } else {
                            self.specialties.removeAll()
                        }
                    }
                    self.collectionView.reloadData()
                }
            }
        }
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
    }
    
}

