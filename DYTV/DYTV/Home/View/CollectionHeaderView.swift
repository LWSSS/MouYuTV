//
//  CollectionHeaderView.swift
//  DYTV
//
//  Created by liuwei on 2018/11/28.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    private var title : String = ""
    private var image : String = ""
    private var titleText : String = ""
    
    
    private lazy var sepLine : UILabel = {
        let sepLine = UILabel()
        sepLine.backgroundColor = UIColor.lightGray
        sepLine.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 15)
        return sepLine
    }()
    
    private lazy var headImageView : UIImageView = {
        let headImageView = UIImageView()
//        headImageView.backgroundColor = UIColor.red
        headImageView.frame = CGRect(x: 10, y: 15, width: 30, height: frame.size.height - 25)
        headImageView.image = UIImage(named: image)
        headImageView.contentMode = .scaleAspectFit
        return headImageView
    }()
    
    private lazy var titleTextLbl : UILabel = {
        let titleTextLbl  = UILabel()
        titleTextLbl.textColor = UIColor.gray
        titleTextLbl.frame = CGRect(x: 45, y: 15, width: 50, height: frame.size.height - 25)
        titleTextLbl.font = UIFont.systemFont(ofSize: 14)
        titleTextLbl.text = titleText
        return titleTextLbl
    }()
    
    private lazy var titleBtn : UIButton = {
       let titleBtn = UIButton()
//        titleBtn.backgroundColor = UIColor.white
        titleBtn.frame = CGRect(x: frame.size.width - 60, y: frame.size.height / 2 - 15, width: 50, height: 30)
        titleBtn.setTitle(title, for: UIControl.State.normal)
        titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        titleBtn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        titleBtn.addTarget(self, action: #selector(clickMore), for: .touchUpInside)
        return titleBtn
    }()

    @objc private  func clickMore(){
        NSLog("click more")
    }
}




extension CollectionHeaderView{
    private func setUpUI(){
        addSubview(sepLine)
        addSubview(headImageView)
        addSubview(titleTextLbl)
        addSubview(titleBtn)
        addSubview(sepLine)
    }
}

extension CollectionHeaderView{
    func setUpHeaderViewWithParamaters(title : String, image : String, titleText: String) {
        self.title = title
        self.image = image
        self.titleText = titleText
        setUpUI()
    }
}
