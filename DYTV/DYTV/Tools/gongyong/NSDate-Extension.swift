//
//  NSDate-Extension.swift
//  DYTV
//
//  Created by liuwei on 2018/12/19.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String{
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
