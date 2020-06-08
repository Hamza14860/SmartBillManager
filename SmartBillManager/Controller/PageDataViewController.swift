//
//  PageDataViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 08/06/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class PageDataViewController: UIViewController {

    var displayText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitle.text = displayText
        // Do any additional setup after loading the view.
    }
    
    var index: Int?

    
    @IBOutlet weak var pageTitle: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
