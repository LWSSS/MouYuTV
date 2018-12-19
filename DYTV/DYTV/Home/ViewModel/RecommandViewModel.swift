//
//  RecommandViewModel.swift
//  DYTV
//
//  Created by liuwei on 2018/12/19.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import UIKit

class RecommandViewModel {
    //懒加载 存放数据  组
    private lazy var anchorGroup : [AnchorGroup] = [AnchorGroup]()
}

//发送网络请求
extension RecommandViewModel{
    func requestData(){
        //1 请求第一部分推荐数据
        
        //2 请求第二部分颜值数据
        
        //3 请求第三部分游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1545224850
//        print(NSDate.getCurrentTime())
        NetworkTool.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]) { (result) in
//            print(result)
            //将result转成字典
            guard let resultDict = result as? [String : NSObject] else {return}
            //根据data的key 获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //便利数组，获取字典，转成模型
            for dict in dataArray {
                let group  = AnchorGroup(dict : dict)
                self.anchorGroup.append(group)
            }
            for group in self.anchorGroup {
                print(group.tag_name)
            }
        }
    }
}
