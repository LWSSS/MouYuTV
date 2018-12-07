//
//  CollectionViewNormalCell.swift
//  DYTV
//
//  Created by liuwei on 2018/12/3.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: UICollectionViewCell {
    private  var title : String = ""
    private  var name : String = ""
    private  var onLineNumber : Int = 0
    
    private lazy var mainView : UIImageView = {
        let mainView = UIImageView()
        mainView.backgroundColor = UIColor.lightGray
        mainView.contentMode = UIView.ContentMode.scaleAspectFill
        mainView.isUserInteractionEnabled = true
        mainView.frame = CGRect(x: 0, y: 0, width: (kScreenW - 30) / 2, height: (kScreenW - 30) / 2 * 0.7 - 20)
        mainView.layer.cornerRadius = 6
        mainView.clipsToBounds = true
        mainView.image = UIImage(named: "Img_default");
        return mainView
    }()
    
    private lazy var subTitleLbl : UILabel = {
       let subTitleLbl = UILabel()
        subTitleLbl.backgroundColor = UIColor.clear
        subTitleLbl.textColor = UIColor.white
        subTitleLbl.font = UIFont.systemFont(ofSize: 8)
        subTitleLbl.text = name
        subTitleLbl.textAlignment = NSTextAlignment.left
        subTitleLbl.frame = CGRect(x: 5, y: mainView.frame.size.height - 10, width: mainView.frame.size.width / 2 - 5, height: 10)
        return subTitleLbl
    }()
    
    private lazy var peopleHeadView : UIImageView = {
        let peopleHeadView = UIImageView()
        peopleHeadView.backgroundColor = UIColor.clear
        peopleHeadView.contentMode = UIView.ContentMode.scaleAspectFit
        peopleHeadView.image = UIImage(named: "Image_online")
        peopleHeadView.frame = CGRect(x: mainView.frame.origin.x + mainView.frame.size.width - 50, y: mainView.frame.size.height - 10, width: 10, height: 10)
        
        return peopleHeadView
    }()
    
    private lazy var peopleNumber : UILabel = {
        let peopleNumber = UILabel()
        peopleNumber.backgroundColor = UIColor.clear
        peopleNumber.font = UIFont.systemFont(ofSize: 8)
        peopleNumber.textColor = UIColor.white
        peopleNumber.textAlignment = NSTextAlignment.right
        peopleNumber.text = NSString(format: "%d", onLineNumber) as String
        peopleNumber.frame = CGRect(x: peopleHeadView.frame.origin.x + 6 + 3, y: mainView.frame.size.height - 10, width: 40, height: 10)
        
        return peopleNumber
    }()
    
    private lazy var videoLogo : UIImageView = {
        let videoLogo = UIImageView()
        videoLogo.backgroundColor = UIColor.clear
        videoLogo.contentMode = UIView.ContentMode.scaleAspectFit
        videoLogo.image = UIImage(named: "home_live_cate_normal")
        videoLogo.frame = CGRect(x: 0, y: mainView.frame.size.height + 3, width: 10, height: 10)
        return videoLogo
    }()
    
    private lazy var titleLbl : UILabel = {
        let titleLbl = UILabel()
        titleLbl.textColor = UIColor.gray
        titleLbl.backgroundColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 12)
        titleLbl.textAlignment = NSTextAlignment.left
        titleLbl.text = title
        titleLbl.frame = CGRect(x: videoLogo.frame.size.width + 3, y: mainView.frame.size.height + 3, width: mainView.frame.size.width - 5, height: 10)
        return titleLbl
    }()
    
}

extension CollectionViewNormalCell{
    private func setUpUI(){
        addSubview(mainView)
        addSubview(subTitleLbl)
        addSubview(peopleHeadView)
        addSubview(peopleNumber)
        addSubview(videoLogo)
        addSubview(titleLbl)
        backgroundColor = UIColor.clear
    }
}

extension CollectionViewNormalCell{
    func SetNormalCellWithParamaters(title: String,name: String,onLineNumber: Int) {
        self.title = title
        self.name = name
        self.onLineNumber = onLineNumber
        setUpUI()
    }
}
