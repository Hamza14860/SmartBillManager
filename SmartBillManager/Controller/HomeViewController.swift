//
//  HomeViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 22/04/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class HomeViewController: UIViewController {

    var catRef: DatabaseReference!
    let storage = Storage.storage()


//    var billCategories: [String:UIImage?] = ["PTCL":UIImage(named: "ptcl"),
//                                             "SUIGAS":UIImage(named: "suigas"),
//                                             "ISECO":UIImage(named: "iesco2")]
//
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        super.tabBarController?.title = "HOME"

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
    @IBAction func infoBillManPressed(_ sender: UIButton) {
        let title: String = "What is Bill Management?"
        let infoMsg: String = "Bill Management allows you to scan/add and store your utility bills in a categorized manner.\n You can view your past bills, update its content, see the stats relating to those bills and also share the bill content."
        displayInfo(title: title, message: infoMsg)
    }
    
    
    @IBAction func infoOcrPressed(_ sender: UIButton) {
        let title: String = "What is Bill Text Scanner?"
        let infoMsg: String = "Using the Bill Text Scanner you will be able to scan bill images by capturing/uploading the image.\n Our AI based server extracts important bill text out of the image and stores it for you so that you dont have to it yourself."
        displayInfo(title: title, message: infoMsg)
    }
    
    @IBAction func infoExpManPressed(_ sender: UIButton) {
        let title: String = "What is Expense Management?"
        let infoMsg: String = "The expense manager allows you to efficently keep track of your expenses.\n You can add your expense items , view the total amount spent each month and also filter them by date."
        displayInfo(title: title, message: infoMsg)
    }
    
    func displayInfo( title: String, message: String) {
        let alert = UIAlertController(title:  title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay.", style: .default) { (action) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
            billCatCell.billCatName.text = billCategoriess[indexPath.item].catName
            billCatCell.billCatImage.image = billCategoriess[indexPath.item].catImage

        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "catToBills" {
            let destinationVC = segue.destination as! BillsTableViewController
               
            if let indexPath = billCatCollectionView.indexPathsForSelectedItems {
                destinationVC.selectedCategory = billCategoriess[indexPath.first!.item]
            }
        }
        else if segue.identifier == "catToOcr"{
            let destinationVC = segue.destination as! AddBillViewController
        }
        else{
            let destinationVC = segue.destination as! ExpenseViewController
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "catToBills", sender: self)
    }
    
    
}
