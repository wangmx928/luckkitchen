//
//  Helper.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/13/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    
    static func sendAlert(title: String, message: String) {
        var alertView: UIAlertView = UIAlertView()
        alertView.title = title
        alertView.message = message
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
    
    static func strToDouble(doubleStr: String) -> Double? {
            return NSNumberFormatter().numberFromString(doubleStr)?.doubleValue
        }
    
}

