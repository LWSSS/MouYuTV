//
//  PageTitleView.swift
//  DYTV
//
//  Created by liuwei on 2018/11/27.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import Foundation
import UIKit

//定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView:PageTitleView, selectIndex index : Int)
}


//定义常量
private let normalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let selectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let scrollLineH : CGFloat = 2

class PageTitleView: UIView {
    private var titles:[String]
    private var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?

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
        scrollLine.backgroundColor = UIColor(r: selectColor.0, g: selectColor.1, b: selectColor.2)
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
            label.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
            label.textAlignment = .center
            //设置frame
           
            let lblX : CGFloat = lblW * CGFloat(index)
            
            label.frame = CGRect(x: lblX, y: lblY, width: lblW, height: lblH)
            
            //label添加到scrollview
            scrollview.addSubview(label)
            titleLables.append(label)
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
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
        firstLbl.textColor = UIColor(r: selectColor.0, g: selectColor.1, b: selectColor.2)
        
        scrollLine.frame = CGRect(x: firstLbl.frame.origin.x, y: frame.height - scrollLineH, width: firstLbl.frame.width, height: scrollLineH)
        
    }
}

//MARK 监听label的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
        print("_____")
        //获取当前label
        guard  let currentLabel = tapGes.view as? UILabel else {return}
        //获取之前的label
        let oldLabel = titleLables[currentIndex]
        if currentLabel.tag == oldLabel.tag {
            return
        }
        //切换文字颜色
        currentLabel.textColor = UIColor(r: selectColor.0, g: selectColor.1, b: selectColor.2)
        oldLabel.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
        //保存最新label的下标
        currentIndex = currentLabel.tag
        
        //滚动条位置改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //o通知代理
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
}

//对外暴漏的方法
extension PageTitleView{
    func setTiteWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        //1.取出spurcelabel/targetlabel
        let sourceLabel = titleLables[sourceIndex]
        let targetLabel = titleLables[targetIndex]
        //2.处理滑块逻辑
        let totalX =  targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let movedX = totalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + movedX
        //3.处理颜色变化
        //3.1取出变化的范围
        let colorDelta = (selectColor.0 - normalColor.0,selectColor.1 - normalColor.1,selectColor.2 - normalColor.2)
        //3.2先变化sourcelabel
        sourceLabel.textColor = UIColor(r: selectColor.0 - colorDelta.0 * progress, g: selectColor.1 - colorDelta.1 * progress, b: selectColor.2 - colorDelta.2 * progress)
        //3.3变化targetlabel
        targetLabel.textColor = UIColor(r: normalColor.0 + colorDelta.0 * progress, g: normalColor.1 + colorDelta.1 * progress, b: normalColor.0 + colorDelta.2 * progress)
        
        //记录最新的index
        currentIndex = targetIndex
    }
}
