//
//  RecommendController.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/14.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3/8
private let kGameViewH : CGFloat = 90

class RecommendController: BaseAnchorContorller {
    
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()

}

extension RecommendController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
    
    override func loadData() {
        //轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleGroups = self.recommendVM.cycleGroups
        }
        
        baseVM = recommendVM
        //推荐数据
        recommendVM.requestData{
            self.collectionView.reloadData()
            
            self.gameView.groups = self.recommendVM.anchorGroups
        }

    }
}

extension RecommendController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath as NSIndexPath).section == 1 {
            let group = recommendVM.anchorGroups[(indexPath as NSIndexPath).section]
            let anchor = group.anchors[(indexPath as NSIndexPath).row]
            let  prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellIdentify, for: indexPath) as! CollectionPrettyCell
            prettyCell.anchor = anchor
            
            return prettyCell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (indexPath as NSIndexPath).section == 1 {
            let size = CGSize(width: kItemWidth, height: kPrettyItemHeight)
            return size
        }
        
        return CGSize(width: kItemWidth, height: kNormalItemHeight)
    }
    
}
