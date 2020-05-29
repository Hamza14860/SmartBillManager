//
//  AddExpenseViewController.swift
//  SmartBillManager
//
//  Created by Ali Rauf on 23/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class AddExpenseViewController: UIViewController {
    
    var index: Int?
    var expenseRef: DatabaseReference!
    var expense: Expense?
    var callbackResult: ((String) -> ())?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var expCategory: UITextField!
    @IBOutlet weak var expItem: UITextField!
    @IBOutlet weak var expAmount: UITextField!
    @IBOutlet weak var expDate: UIDatePicker!
    @IBOutlet weak var expDoneButton: UIButton!
    
    var displayText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = Auth.auth().currentUser?.uid
        expenseRef = Database.database().reference().child("expenses").child(userID!).childByAutoId()
        self.title = "Add Details"
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        print(strDate)
    }
    
    @IBAction func DonePressed(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.medium
        var strDate = " "
        strDate = dateFormatter.string(from: datePicker.date)
        let token = strDate.components(separatedBy: " ")
        strDate = token[1]+" "+token[2]+" "+token[3]
        print(token)
        let expensePost = ["expenseCategory": expCategory.text ?? "",
                        "expenseItem": expItem.text ?? "",
                        "expenseAmount": expAmount.text ?? "",
                        "expenseDate": strDate] as [String : Any]
        expenseRef.setValue(expensePost)
        let alert = UIAlertController(title: "Expense Added", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (alert) in
            self.callbackResult?("hello")
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert,animated: true)
    }
    
}
