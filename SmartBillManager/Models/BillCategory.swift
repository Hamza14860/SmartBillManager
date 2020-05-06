//
//  BillCategory.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 06/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import Foundation
import UIKit

class BillCategory{
    var catName: String
    var catUrl: String
    var userID: String
    var catImage: UIImage
    
    init(catName: String, catUrl: String, userID: String, catImage: UIImage) {
        self.catName = catName
        self.catUrl = catUrl
        self.userID = userID
        self.catImage = catImage
    }
    
//    func toDictionary() -> Any {
//           return ["catName":catName, "catUrl":catUrl, "userID": userID] as Any
//    }
}
