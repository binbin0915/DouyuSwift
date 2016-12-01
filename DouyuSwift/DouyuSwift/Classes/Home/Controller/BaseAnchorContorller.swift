//
//  BaseAnchorContorller.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/12/1.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
let kItemWidth : CGFloat = (kScreenW - 3 * kItemMargin)/2
let kNormalItemHeight : CGFloat = kItemWidth * 3/4
let kPrettyItemHeight : CGFloat = kItemWidth * 4/3
private let kHeaderHeight : CGFloat = 50

private let kCycleViewH = kScreenW * 3/8
private let kGameViewH : CGFloat = 90

private let kNormalCellIdentify : String = "kNormalCellIdentify"
let kPrettyCellIdentify : String = "kPrettyCellIdentify"
private let kHeaderIdentify : String = "kHeaderIdentify"

class BaseAnchorContorller: UIViewController {
    
    var baseVM : BaseViewModel!
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderHeight)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self;
        collectionView.dataSource = self;
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

extension BaseAnchorContorller {
    func setupUI() {
        self.view.addSubview(collectionView)
    }
    
    func loadData() {
        
    }
}

extension BaseAnchorContorller : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellIdentify, for: indexPath) as! CollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderIdentify, for: indexPath) as! CollectionHeaderView
        
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
        
    }
    
}

