//
//  CollectionViewPrettyCell.swift
//  DYTV
//
//  Created by liuwei on 2018/12/7.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import UIKit
import SnapKit


class CollectionViewPrettyCell: UICollectionViewCell {
    private var location : String = ""
    private var title : String = ""
    private  var onLineNumber : Int = 0
    
    private lazy var mainImage : UIImageView = {
        let mainImage = UIImageView()
        mainImage.contentMode = UIView.ContentMode.scaleAspectFill
        mainImage.backgroundColor = UIColor.lightGray
        mainImage.layer.cornerRadius = 5
        mainImage.clipsToBounds = true
        mainImage.image = UIImage(named: "live_cell_default_phone")
        mainImage.isUserInteractionEnabled = true
        
        mainImage.addSubview(onLineNum)
        onLineNum.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(50)
            make.height.equalTo(8)
        })
        return mainImage
    }()
    
    private lazy var onLineNum : UILabel = {
        let onLineNum = UILabel()
        onLineNum.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        onLineNum.textColor = UIColor.white
        onLineNum.textAlignment = NSTextAlignment.center
        onLineNum.font = UIFont.systemFont(ofSize: 8)
        onLineNum.text = NSString(format: "%d在线", onLineNumber) as String
        return onLineNum
    }()
    
    private lazy var titleLbl : UILabel = {
        let titleLbl = UILabel()
        titleLbl.backgroundColor = UIColor.white
        titleLbl.font = UIFont.systemFont(ofSize: 12)
        titleLbl.textColor = UIColor.black
        titleLbl.textAlignment = NSTextAlignment.left
        titleLbl.text = title
        
        return titleLbl
    }()
    
    private lazy var locationImage : UIImageView = {
        let locationImage = UIImageView()
        locationImage.backgroundColor = UIColor.white
        locationImage.contentMode = UIView.ContentMode.scaleAspectFit
        locationImage.image = UIImage(named:"ico_location")
        
        return locationImage
    }()
    
    private lazy var locationLbl : UILabel = {
       let locationLbl = UILabel()
        locationLbl.backgroundColor = UIColor.white
        locationLbl.textColor = UIColor.black
        locationLbl.font = UIFont.systemFont(ofSize: 14)
        locationLbl.textAlignment = NSTextAlignment.left
        locationLbl.text = location
        
        return locationLbl
    }()
}

extension CollectionViewPrettyCell{
    private func setUpUI(){
        addSubview(mainImage)
        mainImage.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.height.equalTo((kScreenW - 30) / 2)
        })
        addSubview(titleLbl)
        titleLbl.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.top.equalTo(mainImage.snp.bottom).offset(3)
            make.height.equalTo(15)
            make.right.equalTo(mainImage.snp.right)
        })
        addSubview(locationImage)
        locationImage.snp.makeConstraints({ (make) in
            make.top.equalTo(titleLbl.snp.bottom).offset(3)
            make.left.equalTo(0)
            make.width.height.equalTo(15)
        })
        addSubview(locationLbl)
        locationLbl.snp.makeConstraints({ (make) in
            make.top.equalTo(locationImage.snp.top)
            make.left.equalTo(locationImage.snp.right).offset(3)
            make.right.equalTo(mainImage.snp.right)
            make.height.equalTo(15)
        })
    }
}

extension CollectionViewPrettyCell{
    func setUpPrettyCellWithParagram(location: String,title: String,onlineNumber: Int)  {
        self.location = location
        self.title = title
        self.onLineNumber = onlineNumber
        setUpUI()
    }
}


