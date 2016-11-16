//
//  RecommendController.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/14.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemWidth : CGFloat = (kScreenW - 3 * kItemMargin)/2
private let kNormalItemHeight : CGFloat = kItemWidth * 3/4
private let kPrettyItemHeight : CGFloat = kItemWidth * 4/3
private let kHeaderHeight : CGFloat = 50

private let kNormalCellIdentify : String = "kNormalCellIdentify"
private let kPrettyCellIdentify : String = "kPrettyCellIdentify"
private let kHeaderIdentify : String = "kHeaderIdentify"

class RecommendController: UIViewController {
    
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderHeight)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellIdentify)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellIdentify)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderIdentify)
        
        

        return collectionView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        loadData()
    
    }


}

extension RecommendController {
    func setupUI() {
        self.view.addSubview(collectionView)
        
    }
    
    func loadData() {
        recommendVM.requestData{
            print("self.collectionView.reloadData")
            self.collectionView.reloadData()
        }
    }
}

extension RecommendController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = recommendVM.anchorGroups[(indexPath as NSIndexPath).section]
        let anchor = group.anchors[(indexPath as NSIndexPath).row]
        var cell : UICollectionViewCell!
        if (indexPath as NSIndexPath).section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellIdentify, for: indexPath)
            (cell as! CollectionPrettyCell).anchor = anchor
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellIdentify, for: indexPath)
            (cell as! CollectionNormalCell).anchor = anchor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView : CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderIdentify, for: indexPath) as! CollectionHeaderView
        let group = recommendVM.anchorGroups[(indexPath as NSIndexPath).section]
        headerView.group = group

        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size : CGSize
        if (indexPath as NSIndexPath).section == 1 {
            size = CGSize(width: kItemWidth, height: kPrettyItemHeight)
            return size
        }
        size = CGSize(width: kItemWidth, height: kNormalItemHeight)
        return size
    }
    
}