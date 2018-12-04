//
//  CommandViewController.swift
//  DYTV
//
//  Created by liuwei on 2018/11/28.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import UIKit

private let itemMargin : CGFloat = 10
private let itemW = (kScreenW - 3 * itemMargin) / 2
private let itemH = itemW * 3 / 4
private let normalCellID = "normalCellID"
private let normalHeaderID = "normalHeaderID"
private let headerH : CGFloat = 50

class CommandViewController: UIViewController {
    //系统回调函数
    private lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建layout
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing  = itemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: headerH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.blue
        collectionView.dataSource = self
         collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
         collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: normalHeaderID)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: normalCellID)
        setUpUI()
       
       
        // Do any additional setup after loading the view.
    }

}


//设置ui
extension CommandViewController{
    private func setUpUI(){
        view.addSubview(collectionView)
    }
}


//uicollectionviewdatasource
extension CommandViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellID, for: indexPath)
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出session headview
        let headrView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: normalHeaderID, for: indexPath)as! CollectionHeaderView
        headrView.backgroundColor = UIColor.white
        headrView.setUpHeaderViewWithParamaters(title: "更多 >", image: "home_header_normal",titleText:"热门")
        return headrView
    }
}
