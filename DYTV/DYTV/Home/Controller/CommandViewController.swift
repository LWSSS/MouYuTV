

import UIKit
import Alamofire

private let itemMargin : CGFloat = 10
private let itemW = (kScreenW - 3 * itemMargin) / 2
private let itemH = itemW * 3 / 4
private let prettyitemH = itemW * 4 / 3
private let normalCellID = "normalCellID"
private let prettyCellID = "prettyCellID"
private let normalHeaderID = "normalHeaderID"
private let headerH : CGFloat = 50

class CommandViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    //系统回调函数
    private lazy var recommandVM : RecommandViewModel = RecommandViewModel()
    private lazy var maincollectionView : UICollectionView = {[unowned self] in
        //1.创建layout
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing  = itemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: headerH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        
        let maincollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        maincollectionView.register(CollectionViewNormalCell.self, forCellWithReuseIdentifier: normalCellID)
        maincollectionView.register(CollectionViewPrettyCell.self, forCellWithReuseIdentifier: prettyCellID)
        maincollectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: normalHeaderID)
        
        maincollectionView.delegate = self
        maincollectionView.dataSource = self
        maincollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        maincollectionView.backgroundColor = UIColor.white
        return maincollectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        setUpUI()
       
        loadData()
        
//        NetworkTool.requestData(.GET, URLString:"https://httpbin.org/get" , parameters:  ["name" : "JSON"]) { (result) in
//            print(result)
//        }
//        
       
        // Do any additional setup after loading the view.
    }

}


//设置ui
extension CommandViewController{
    private func setUpUI(){
        view.addSubview(maincollectionView)
        view.backgroundColor = UIColor.white
    }
}

//请求数据
extension CommandViewController{
    private func loadData(){
        recommandVM.requestData()
    }
}


//uicollectionviewdatasource
extension CommandViewController {
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
//        var cell : UICollectionViewCell!
        if indexPath.section == 1 {
            let cell : CollectionViewPrettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellID, for: indexPath) as!
                CollectionViewPrettyCell
            cell.setUpPrettyCellWithParagram(location: "beijing", title: "have_a_test", onlineNumber: 100)
            return cell
        }else{
            let cell :CollectionViewNormalCell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellID, for: indexPath) as! CollectionViewNormalCell
            
            
            cell.SetNormalCellWithParamaters(title: "have a test", name: "xianyu_666", onLineNumber: 999)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出session headview
        let headrView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: normalHeaderID, for: indexPath)as! CollectionHeaderView
        headrView.backgroundColor = UIColor.white
        headrView.setUpHeaderViewWithParamaters(title: "更多 >", image: "home_header_normal",titleText:"热门")
        return headrView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: itemW, height: prettyitemH - 15)
        }
        return CGSize(width: itemW, height: itemH)
    }
}
