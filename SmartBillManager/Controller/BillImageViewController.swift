//
//  BillImageViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 13/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class BillImageViewController: UIViewController {
    
    var selectedBill: Bill? {
        didSet{
        }
    }
    @IBOutlet weak var displayLabel: UILabel!
    
    var index: Int?
    var displayText: String?
    @IBOutlet weak var ivBillImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = displayText
        
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
