//
//  User.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 05/05/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import Foundation

class User{
    var Email: String
    var Name: String
    var ProfileUrl: String
    
    init(Email: String, Name: String, ProfileUrl: String) {
        self.Email = Email
        self.Name = Name
        self.ProfileUrl = ProfileUrl
    }
    
    func toDictionary() -> Any {
        return ["Email":Email, "Name":Name, "ProfileUrl": ProfileUrl] as Any
    }
}
