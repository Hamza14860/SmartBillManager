//
//  Bill.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 07/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import Foundation
import UIKit

class Bill {
    var billAddNote: String
    var billAmount: String
    var billCategory: String
    var billCustomerName: String
    var billDate: String
    var billImageUrl: String
    
    var billText: [String:String]
    
    var billImage: UIImage
    
    var billId: String

    
    init(billAddNote:String,billAmount:String,billCategory:String,billCustomerName:String,billDate:String,billImageUrl:String, billText:[String:String], billImage: UIImage, billId: String) {
        self.billAddNote = billAddNote
        self.billAmount = billAmount
        self.billDate = billDate
        self.billText = billText
        self.billCategory = billCategory
        self.billImageUrl = billImageUrl
        self.billCustomerName = billCustomerName
        
        self.billImage = billImage
        
        self.billId = billId
    }
}
