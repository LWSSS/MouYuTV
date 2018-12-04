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
    
    
    
}

extension CollectionViewNormalCell{
    private func setUpUI(){
        
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
