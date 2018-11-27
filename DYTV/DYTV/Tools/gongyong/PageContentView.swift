//
//  PageContentView.swift
//  DYTV
//
//  Created by liuwei on 2018/11/27.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import UIKit

private  let contentCellID = "contentCellID"


class PageContentView: UIView {
    
    //定义属性
    private  var childVCs : [UIViewController]
    private  var parentVC : UIViewController
    
    //懒加载属性
    private lazy var collectionView : UICollectionView = {
        //1.z创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建uicollectionview
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    //自定义构造函数
     init(frame: CGRect, childVCs : [UIViewController],parentVC : UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame : frame)
        
         setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//设置ui界面
extension PageContentView {
    private func setupUI(){
        //1.将所有的子控制器加入到父控制器中
        for childVC in childVCs {
            parentVC.addChild(childVC)
        }
        //2.添加UICollectionView用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


//UICollectionView DataSource

extension PageContentView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        //给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
    
}
