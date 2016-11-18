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

private let kCycleViewH = kScreenW * 3/8
private let kGameViewH : CGFloat = 90

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
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        cycleView.backgroundColor = UIColor.red
        return cycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
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
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
    
    func loadData() {
        //轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleGroups = self.recommendVM.cycleGroups
        }
        
        //推荐数据
        recommendVM.requestData{
            self.collectionView.reloadData()
            
            self.gameView.groups = self.recommendVM.anchorGroups
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
        var cell : CollectionBaseCell!
        if (indexPath as NSIndexPath).section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellIdentify, for: indexPath) as! CollectionBaseCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellIdentify, for: indexPath) as! CollectionBaseCell
        }
        cell.anchor = anchor
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
