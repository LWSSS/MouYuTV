//
//  PageTitleView.swift
//  DYTV
//
//  Created by liuwei on 2018/11/27.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import Foundation
import UIKit

private let scrollLineH : CGFloat = 2

class PageTitleView: UIView {
    private var titles:[String]

    private lazy var titleLables : [UILabel] = [UILabel]()
    
    private lazy var scrollview : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        scrollview.isPagingEnabled = false
        scrollview.bounces = false
        return scrollview
    }()
    
    private lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //自定义构造函数
     init(frame: CGRect, titles: [String]) {
        self.titles = titles;
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PageTitleView{
    private func setupUI(){
        //添加UIScrollView
        addSubview(scrollview)
        scrollview.frame = bounds
        // 添加title对应的label
        setupTitleLabels()
        
        //设置底线和滚动滑块
        setupBottomMenuAndScrollLine()
    }
    
    // 添加title对应的label
    private func setupTitleLabels(){
        let lblW : CGFloat = frame.width / CGFloat( titles.count )
        let lblH : CGFloat = frame.height - scrollLineH
        let lblY : CGFloat = 0
        for (index, title) in titles.enumerated()  {
            //创建uilabel
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            //设置frame
           
            let lblX : CGFloat = lblW * CGFloat(index)
            
            label.frame = CGRect(x: lblX, y: lblY, width: lblW, height: lblH)
            
            //label添加到scrollview
            scrollview.addSubview(label)
            titleLables.append(label)
        }
    }
    
    //设置底线和滚动滑块
    private func setupBottomMenuAndScrollLine(){
        let BottomLine = UIView()
        BottomLine.backgroundColor = UIColor.lightGray
        let lineH :CGFloat  = 0.5
        BottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(BottomLine)
        
        scrollview.addSubview(scrollLine)
        //获取第一个lbl
        guard let firstLbl = titleLables.first else {
            return
        }
        firstLbl.textColor = UIColor.orange
        
        scrollLine.frame = CGRect(x: firstLbl.frame.origin.x, y: frame.height - scrollLineH, width: firstLbl.frame.width, height: scrollLineH)
        
    }
}
