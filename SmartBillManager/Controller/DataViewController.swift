//
//  DataViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 13/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

   var index: Int?
    
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
    
    var displayText: String?
    
    override func viewDidLoad() {
           super.viewDidLoad()
        displayLabel.text = displayText

    }
    @IBAction func updateTextPressed(_ sender: UIButton) {
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
