//
//  DataViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 13/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class BillTextViewController: UIViewController {

    var selectedBill: Bill? {
        didSet{
        }
    }
    
    var index: Int?
    
    var billRef: DatabaseReference!

    @IBOutlet weak var billTitle: UILabel!
    @IBOutlet weak var viewPhoneNo: UIView!
    @IBOutlet weak var viewUnitsMeterNo: UIView!
    @IBOutlet weak var billNote: UITextField!
    @IBOutlet weak var billMeterNo: UITextField!
    @IBOutlet weak var billUnits: UITextField!
    @IBOutlet weak var billPhone: UITextField!
    @IBOutlet weak var billCustAddress: UITextField!
    @IBOutlet weak var billDate: UITextField!
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var billCustName: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    
    var displayText: String?
    
    var billTextUpdated = [String:String]()
    
    override func viewDidLoad() {
           super.viewDidLoad()
        displayLabel.text = displayText
        billCustName.text = selectedBill?.billCustomerName
        billNote.text = selectedBill?.billAddNote
        billAmount.text = selectedBill?.billAmount
        billDate.text = selectedBill?.billDate
        billTitle.text = selectedBill?.billCategory
        
        billCustAddress.text = selectedBill?.billText["Address"]
        
        billTextUpdated = selectedBill?.billText as! [String : String]
        
        
        let userID = Auth.auth().currentUser?.uid
        if let billID = selectedBill?.billId {
            billRef = Database.database().reference().child("bills").child(userID!).child(billID)
        }
        else {
            btnUpdate.isEnabled = false
        }
        
        if selectedBill?.billCategory == "PTCL" {
            viewUnitsMeterNo.alpha = 0.4
            billUnits.isEnabled = false
            billMeterNo.isEnabled = false
            billUnits.backgroundColor = UIColor.lightGray
            billMeterNo.backgroundColor = UIColor.lightGray
            
            billPhone.text = selectedBill?.billText["PhoneNumber"]
        }
        else {
            viewPhoneNo.alpha = 0.4
            billPhone.isEnabled = false
            billPhone.backgroundColor = UIColor.lightGray
            
            billUnits.text = selectedBill?.billText["Units"]
            billMeterNo.text = selectedBill?.billText["Meter"]
        }

    }
    
    
    
    @IBAction func updateTextPressed(_ sender: UIButton) {
        if selectedBill?.billCategory == "PTCL" {
            billTextUpdated["PhoneNumber"] = billPhone.text
            billTextUpdated["Address"] = billCustAddress.text
            billTextUpdated["Amount"] = billAmount.text
            billTextUpdated["Date"] = billDate.text


            
            let billPost = ["billCustomerName": billCustName.text,
                            "billAddNote": billNote.text,
                            "billAmount": billAmount.text,
                            "billDate": billDate.text,
                            "billText": billTextUpdated] as [String : Any]
            billRef.updateChildValues(billPost)
            
        }
        else {
            billTextUpdated["Units"] = billUnits.text
            billTextUpdated["Meter"] = billMeterNo.text
            billTextUpdated["Address"] = billCustAddress.text
            billTextUpdated["Amount"] = billAmount.text
            billTextUpdated["Date"] = billDate.text

            let billPost = ["billCustomerName": billCustName.text,
                            "billAddNote": billNote.text,
                            "billAmount": billAmount.text,
                            "billDate": billDate.text,
                            "billText": billTextUpdated] as [String : Any]
            billRef.updateChildValues(billPost)
            
        }
//        let billPost = ["billCustomerName": billCustName.text,
//                        "billAddNote": billNote.text,
//                        "billAmount": billAmount.text,
//        "billDate": billDate.text]
//        billRef.updateChildValues(billPost)
        
        
        let alert = UIAlertController(title: "Bill Text Updated", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (alert) in


        }))

        self.present(alert,animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
