//
//  Expense.swift
//  SmartBillManager
//
//  Created by Ali Rauf on 22/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import Foundation
class Expense{
    var category: String = "Not Defined"
    var item: String = ""
    var amount: Double = 0
    var dateCreated: String = ""
    var expenseId: String
    init(category: String, item: String, amount: Double, dateCreated: String, expenseId: String) {
        self.category = category
        self.item = item
        self.amount = amount
        self.dateCreated = dateCreated
        self.expenseId = expenseId
    }
}
