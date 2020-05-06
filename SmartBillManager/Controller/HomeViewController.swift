//
//  HomeViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 22/04/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var catRef: DatabaseReference!
    let storage = Storage.storage()


    var billCategories: [String:UIImage?] = ["PTCL":UIImage(named: "ptcl"),
                                             "SUIGAS":UIImage(named: "suigas"),
                                             "ISECO":UIImage(named: "iesco2")]
    
    var billCategoriess = [BillCategory]()


    @IBOutlet weak var billCatCollectionView: UICollectionView! {
        didSet {
            billCatCollectionView.dataSource = self
            billCatCollectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.tabBarController?.title = "HOME"
        
        
        catRef = Database.database().reference().child("Categories")

        
        loadCategories()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.tabBarController?.navigationItem.hidesBackButton = true
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
       }
    
    
    func loadCategories(){
        // Listen for new categories in the Firebase database
        catRef.observe(.value, with: { snapshot in
            
            self.billCategoriess = [] //empty out Categories array

            print("Category Count: \(snapshot.childrenCount) ...")
            
            for category in snapshot.children {
             
                
                let snap = category as! DataSnapshot
                let catDict = snap.value as! [String: Any]
                let catName = catDict["catName"] as! String
                let catUrl = catDict["catUrl"] as! String
                let userID = catDict["userID"] as! String
                
                var tempImg = UIImage()

                //Dowload Image from Storage
                var httpsReference = self.storage.reference(forURL: catUrl)
                httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                  if let error = error {
                    print("Image Not Downloaded: \(error)")
                  } else {
                    tempImg = UIImage(data: data!)!
                    print("image downloaded \(tempImg)")
                    
                    let newCategory = BillCategory(catName: catName, catUrl: catUrl, userID: userID, catImage: tempImg)
                    print(newCategory.catName)
                    self.billCategoriess.append(newCategory)
                    
                    //Update Collection View
                    DispatchQueue.main.async { //Fetch main thread to update data
                        self.billCatCollectionView.reloadData()
                    }

                  }
                }
                
               
            }


        })
    }


}

//MARK:- Collection View Methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return billCategoriess.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "billCatCell", for: indexPath)
        if let billCatCell = cell as? BillCatCollectionViewCell {
//            billCatCell.billCatImage.image = Array(billCategories)[indexPath.item].value
//            billCatCell.billCatName.text = Array(billCategories)[indexPath.item].key
            
            billCatCell.billCatName.text = billCategoriess[indexPath.item].catName
            billCatCell.billCatImage.image = billCategoriess[indexPath.item].catImage

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
}
