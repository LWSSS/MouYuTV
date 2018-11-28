//
//  HomeVC.swift
//  DYTV
//
//  Created by liuwei on 2018/11/27.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import Foundation

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeVC: UIViewController {
    //懒加载PageTitleView
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame  = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + 30, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
//        titleView.backgroundColor = UIColor.purple
        return titleView
    }()
    
    //懒加载pagecontentview
    private lazy var pageContentView : PageContentView = {[weak self] in
        //确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - 30 - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH + 30, width: kScreenW, height: contentH)
        //确定内容的子控制器
        var childVCs = [UIViewController]()
        childVCs.append(CommandViewController())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentVC: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
//        self.title = "首页"
        
        setupUI()
    }
    
    
    
    override func  didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

//设置ui界面
extension HomeVC {
    private func setupUI(){
        //不需要系统添加内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        //添加titleview
        view.addSubview(pageTitleView)
        //添加contentview
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar(){
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        let size = CGSize(width: 40, height: 40)
        //***原始方法
//        let historyBtn = UIButton()
//        historyBtn.setImage(UIImage(named: "image_my_history"), for: .normal)
//        historyBtn.setImage(UIImage(named: "image_my_history_click"), for: .highlighted)
//        historyBtn.frame = CGRect(origin: CGPoint.zero, size: size)
         //***使用便利构造函数
//        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", highImage: "image_my_history_click", size: size)
        //***使用extension扩展类方法
        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highLightImageName: "Image_my_history_click", size: size)
        
//        let searchBtn = UIButton()
//        searchBtn.setImage(UIImage(named: "btn_search"), for: .normal)
//        searchBtn.setImage(UIImage(named: "btn_search_clicked"), for: .highlighted)
//        searchBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highLightImageName: "btn_search_clicked", size: size)
        
//        let QRCodeBtn = UIButton()
//        QRCodeBtn.setImage(UIImage(named: "Image_scan"), for: .normal)
//        QRCodeBtn.setImage(UIImage(named: "Image_scan_click"), for: .highlighted)
//        QRCodeBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        let QRCodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highLightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,QRCodeItem]
    }
}


//遵守pagetitleviewdelegate
extension HomeVC : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//遵守pagecontentviewdelegate
extension HomeVC : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTiteWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

