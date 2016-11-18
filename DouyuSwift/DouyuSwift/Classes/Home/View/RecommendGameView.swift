//
//  RecommendGameView.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/17.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

private let kRecomGameCellIdentify = "RecomGameCellIdentify"

class RecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups : [AnchorGroup]? {
        didSet {
            groups?.removeFirst()
            groups?.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //让空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kRecomGameCellIdentify)
    }

}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = groups?[(indexPath as NSIndexPath).row]
        let cell : CollectionGameCell! = collectionView.dequeueReusableCell(withReuseIdentifier: kRecomGameCellIdentify, for: indexPath) as! CollectionGameCell;
        cell.group = group
        return cell
        
    }
}
