//
//  TutorialModel.swift
//  SmartBillManager
//
//  Created by Hamza Azam on 09/06/2020.
//  Copyright © 2020 Hamza Azam. All rights reserved.
//

import Foundation
import UIKit

class TutorialModel {
    var title: String
    var message: String
    var imageNo: Int
    
    init(t:String,m:String,i:Int){
       title = t
        message = m
        imageNo = i
    }
}
