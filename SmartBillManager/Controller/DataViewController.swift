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
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var displayText: String?
    
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
