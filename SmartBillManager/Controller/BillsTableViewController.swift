//
//  BillsTableViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 06/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class BillsTableViewController: UITableViewController {
    
    var billRef: DatabaseReference!
    let storage = Storage.storage()
    
    var bills = [Bill]()
    
    var selectedCategory: BillCategory? {
        didSet{
            let userID = Auth.auth().currentUser?.uid
            billRef = Database.database().reference().child("bills").child(userID!)
            loadBills()
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //print(selectedCategory!.catName)
        self.title = "\(selectedCategory!.catName) Bills"
        
        let userID = Auth.auth().currentUser?.uid
        billRef = Database.database().reference().child("bills").child(userID!)
        
        //TBD
        //bills.append(Bill(billAddNote: "-", billAmount: "2930", billCategory: "PTCL", billCustomerName: "Lorem Irepsum", billDate: "09/06/2020", billImageUrl: "-", billText: ["-":"-"], billImage: UIImage(named: "bi3")!))
        //bills.append(Bill(billAddNote: "-", billAmount: "2930", billCategory: "IESCO", billCustomerName: "Lorem Irepsum", billDate: "09/06/2020", billImageUrl: "-", billText: ["-":"-"], billImage: UIImage(named: "bi3")!))
        
    }
    
    
    func loadBills(){
           // Listen for new categories in the Firebase database
        billRef.observe(.value, with: { snapshot in
            self.bills = [] //empty out Bills array
            print("Bills Count: \(snapshot.childrenCount) ...")
               
            for bill in snapshot.children {
                let snap = bill as! DataSnapshot
                
                let billDict = snap.value as! [String: Any]
                let billAmount = billDict["billAmount"] as? String
                let billCategory = billDict["billCategory"] as? String
                let billCustomerName = billDict["billCustomerName"] as? String
                let billDate = billDict["billDate"] as? String
                let billImageUrl = billDict["billImageUrl"] as! String

                let billAddNote = billDict["billAddNote"] as? String
                let billId = snap.key
                
                let billText = billDict["billText"] as! [String:String]
                //print (billText)


                if self.selectedCategory?.catName == billCategory && billImageUrl != "None Chosen" {
                    var tempImg = UIImage()

                    //Dowload Image from Storage
                    var httpsReference = self.storage.reference(forURL: billImageUrl)
                    httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                        if let error = error {
                            print("Image Not Downloaded: \(error)")
                        } else {
                            tempImg = UIImage(data: data!)!
                            print("image downloaded \(tempImg)")
                                          
                            //TODO:- BILL TEXT TO BE UPDATED
                            let newBill = Bill(billAddNote: billAddNote ?? "-", billAmount: billAmount ?? "0", billCategory: billCategory ?? "PTCL", billCustomerName: billCustomerName ?? "-", billDate: billDate ?? "-", billImageUrl: billImageUrl, billText: billText,billImage: tempImg, billId: billId)
                                           
                            print(newBill.billCustomerName)
                                          
                            self.bills.append(newBill)
                                          
                            //Update Collection View
                            DispatchQueue.main.async { //Fetch main thread to update data
                                self.tableView.reloadData()
                            }
                            
                        }
                    }
                }
                
                else if self.selectedCategory?.catName == billCategory && billImageUrl == "None Chosen"{
                    let tempImg = UIImage(named: "bill1")!
                    print("image loaded \(tempImg)")
                                  
                    //TODO:- BILL TEXT TO BE UPDATED
                    let newBill = Bill(billAddNote: billAddNote ?? "-", billAmount: billAmount ?? "0", billCategory: billCategory ?? "PTCL", billCustomerName: billCustomerName ?? "-", billDate: billDate ?? "-", billImageUrl: billImageUrl, billText: billText,billImage: tempImg, billId: billId)
                                   
                    print(newBill.billCustomerName)
                                  
                    self.bills.append(newBill)
                                  
                    //Update Collection View
                    DispatchQueue.main.async { //Fetch main thread to update data
                        self.tableView.reloadData()
                    }
                }

            }
        })
    }


    
    // MARK: - Table view data source Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath) as! BillTableViewCell

        // Configure the cell...
        let bill = bills[indexPath.row]
        cell.lblBillAmount?.text = bill.billAmount
        cell.lblBillCat?.text = bill.billCategory
        cell.lblBillCustName?.text = bill.billCustomerName
        cell.lblBillMonth?.text = bill.billDate
        
        cell.ivBillImage.image = bill.billImage
        
        return cell
    }
    
    //To limit row height of table view
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "billToBillDetail" {
               let destinationVC = segue.destination as! BillDetailsViewController
                  
               if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedBill = bills[indexPath.row]
               }
           }
           
           
       }
    
    //MARK: - Table View Delegate Methods
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "billToBillDetail", sender: self)
       }

}
