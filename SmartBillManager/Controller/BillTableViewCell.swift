//
//  BillTableViewCell.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 06/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import UIKit

class BillTableViewCell: UITableViewCell {

   
    @IBOutlet weak var lblBillAmount: UILabel!
    @IBOutlet weak var lblBillCat: UILabel!
    @IBOutlet weak var lblBillMonth: UILabel!
    @IBOutlet weak var lblBillCustName: UILabel!
    @IBOutlet weak var ivBillImage: UIImageView!
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
