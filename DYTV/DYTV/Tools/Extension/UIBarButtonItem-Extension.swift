//
//  UIBarButtonItem-Extension.swift
//  DYTV
//
//  Created by liuwei on 2018/11/27.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import Foundation

import UIKit

extension UIBarButtonItem {

     //extension类方法
    class func createItem(imageName: String, highLightImageName: String, size : CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highLightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    //便利构造函数 1-> convenience  started 2 -> 在构造函数种必须明确调用一个设计的构造函数(self)
//   convenience init(imageName : String, highImage: String , size : CGSize){
//    let btn = UIButton()
//    btn.setImage(UIImage(named: imageName), for: .normal)
//    btn.setImage(UIImage(named: highImage), for: .highlighted)
//    btn.frame = CGRect(origin: CGPoint.zero, size: size)
//    self.init(customView:btn)
//    }
}
