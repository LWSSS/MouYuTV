//
//  MyTabBarVC.swift
//  DYTV
//
//  Created by liuwei on 2018/11/27.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import Foundation

import UIKit

class MyTabBarVC: UITabBarController {
    
    let Home =  HomeVC()
    let Live = LiveVC()
    let Follow = FollowVC()
    let User = UserVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.red
        addChildViewControllers()
        
        tabBar.tintColor = UIColor.red
    }
    
    
    func addChildViewControllers()  {
        setChildViewController(Home, title: "首页", imageName: "home_tabbar_32x32_", selectImage: "home_tabbar_press_32x32_")
        setChildViewController(Live, title: "直播", imageName: "video_tabbar_32x32_", selectImage: "video_tabbar_press_32x32_")
        setChildViewController(Follow, title: "关注", imageName: "huoshan_tabbar_32x32_", selectImage: "huoshan_tabbar_press_32x32_")
        setChildViewController(User, title: "我的", imageName: "mine_tabbar_32x32_", selectImage: "mine_tabbar_press_32x32_")
    }
    
    /// 初始化子控制器
    func setChildViewController(_ childController: UIViewController, title: String, imageName: String, selectImage: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectImage)
        childController.tabBarItem.title = title
        
        //添加导航控制器为 UITabBarController 的字控制器
        let navVC = MyNavigationVC(rootViewController: childController)
        
        addChild(navVC)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
