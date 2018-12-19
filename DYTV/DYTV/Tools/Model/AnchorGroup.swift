//
//  AnchorGroupModel.swift
//  DYTV
//
//  Created by liuwei on 2018/12/19.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    //改组中对应的房间信息
    var room_list : [[String : NSObject]]?
    //组显示的标题
    var tag_name : String = ""
    //该组显示的图标
    var icon_name : String = "home_header_normal"
    
    init(dict : [String : Any]){
        super.init()
        //kvc转模型
//        setValuesForKeys(dict)
        tag_name = dict["tag_name"] as! String
        room_list = dict["room_list"] as? [[String : NSObject]]
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
