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
        UITabBar.appearance().tintColor = UIColor.orange
        addChildViewControllers()
        
        tabBar.tintColor = UIColor.red
    }
    
    
    func addChildViewControllers()  {
        setChildViewController(Home, title: "首页", imageName: "btn_home_normal", selectImage: "btn_home_selected")
        setChildViewController(Live, title: "直播", imageName: "btn_column_normal", selectImage: "btn_column_selected")
        setChildViewController(Follow, title: "关注", imageName: "btn_live_normal", selectImage: "btn_live_selected")
        setChildViewController(User, title: "我的", imageName: "btn_user_normal", selectImage: "btn_user_selected")
    }
    
    /// 初始化子控制器
    func setChildViewController(_ childController: UIViewController, title: String, imageName: String, selectImage: String) {
        childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: selectImage)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.title = title
        
        //添加导航控制器为 UITabBarController 的字控制器
        let navVC = MyNavigationVC(rootViewController: childController)
        
        addChild(navVC)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
