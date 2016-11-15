//
//  Date-Extension.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/15.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
