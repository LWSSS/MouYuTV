//
//  PageContentView.swift
//  DYTV
//
//  Created by liuwei on 2018/11/27.
//  Copyright © 2018年 com.LW. All rights reserved.
//

import UIKit

private  let contentCellID = "contentCellID"

protocol PageContentViewDelegate : class{
    func pageContentView(contentView: PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

class PageContentView: UIView {
    
    //定义属性
    private  var childVCs : [UIViewController]
    private weak var parentVC : UIViewController?
    private var startContentOffsetX: CGFloat = 0
    private var isForbidScrollViewDelegate: Bool = false
    weak var delegate : PageContentViewDelegate?
    
    //懒加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in
        //1.z创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建uicollectionview
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    //自定义构造函数
     init(frame: CGRect, childVCs : [UIViewController],parentVC : UIViewController?) {
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
            parentVC?.addChild(childVC)
        }
        //2.添加UICollectionView用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


//uicollectiondelegate
extension PageContentView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbidScrollViewDelegate {
            return
        }
        
        
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startContentOffsetX {
            //左滑1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //2.计算sourceindex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //3.计算targetindex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count{
                targetIndex = childVCs.count - 1
            }
            //滑动结束
            if currentOffsetX - startContentOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            //右滑1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //2.计算targetindex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //3.计算sourceindex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count{
                sourceIndex = childVCs.count - 1
            }
        }
        //将progress,sourceindex,targetindex传给titleview
//        print("progress:\(progress)  sourceindex:\(sourceIndex)  targetindex:\(targetIndex)")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollViewDelegate = false
       startContentOffsetX =  scrollView.contentOffset.x
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


//mmark 对外暴漏的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int){
        //记录需要执行代理方法
        isForbidScrollViewDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
