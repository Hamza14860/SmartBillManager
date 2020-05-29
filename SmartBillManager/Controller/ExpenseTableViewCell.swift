//
//  ExpenseTableViewCell.swift
//  SmartBillManager
//
//  Created by Ali Rauf on 23/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import Foundation
import UIKit
class ExpenseTableViewCell: UITableViewCell {

   
    @IBOutlet weak var lblItem: UILabel!
    
    @IBOutlet weak var lblAmount: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
