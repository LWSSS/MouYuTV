//
//  UIColor_Extension.swift
//  DYTV
//
//  Created by liuwei on 2018/11/27.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    convenience init(r:CGFloat , g:CGFloat ,b:CGFloat){
        self.init(red:r/255.0 ,green:g/255.0 ,blue:b/255.0 ,alpha:1 )
    }
}
