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
    
    private lazy var sepLine : UILabel = {
        let sepLine = UILabel()
        sepLine.backgroundColor = UIColor.lightGray
        return sepLine
    }()
    
    init(frame: CGRect, title : String, image : String) {
        self.title = title
        self.image = image
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension CollectionHeaderView{
    private func setUpUI(){
        addSubview(sepLine)
    }
}
