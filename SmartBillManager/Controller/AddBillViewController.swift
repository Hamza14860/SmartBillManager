//
//  AddBillViewController.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 07/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bill Text Scanner"

    }
    
    @IBOutlet weak var ivBillImage: UIImageView!
    
    
    @IBAction func uploadImagePressed(_ sender: UIButton) {
    }
    
    @IBAction func captureImagePressed(_ sender: UIButton) {
    }
    
    
    @IBAction func scanImagePressed(_ sender: UIButton) {
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
