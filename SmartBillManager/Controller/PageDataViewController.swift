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
    var mess: String?
  
    var index: Int?
    var imageNo: Int?

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var pageTitle: UILabel!
    
   
    override func viewDidLoad() {
          super.viewDidLoad()
        pageTitle.text = displayText
        message.text = mess
        if imageNo == 1 {
            image.image = UIImage(named: "tutimg")
        }
        else if imageNo == 2 {
            image.image = UIImage(named: "billscanimg")

        }
        else {
            image.image = UIImage(named: "expimg")

        }
      }
      

}
