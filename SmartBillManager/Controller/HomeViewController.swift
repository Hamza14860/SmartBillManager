//
//  HomeViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 22/04/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var billCategories: [UIImage?] = [UIImage(named: "ptcl"),UIImage(named: "suigas"),UIImage(named: "iesco")]
    
    @IBOutlet weak var billCatCollectionView: UICollectionView! {
        didSet {
            billCatCollectionView.dataSource = self
            billCatCollectionView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.tabBarController?.title = "HOME"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.tabBarController?.navigationItem.hidesBackButton = true
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
       }


}

//MARK:- Collection View Methods
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return billCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "billCatCell", for: indexPath)
        if let billCatCell = cell as? BillCatCollectionViewCell {
            billCatCell.billCatImage.image = billCategories[indexPath.item]
        }
        return cell
    }
    
    
}
