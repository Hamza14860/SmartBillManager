//
//  BillCategory.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 06/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import Foundation

class BillCategory{
    var catName: String
    var catUrl: String
    var userID: String
    
    init(catName: String, catUrl: String, userID: String) {
        self.catName = catName
        self.catUrl = catUrl
        self.userID = userID
    }
    
    func toDictionary() -> Any {
           return ["catName":catName, "catUrl":catUrl, "userID": userID] as Any
    }
}
