//
//  RecommendCycleView.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/17.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

private let kCycleCellIdentify = "CycleCellIdentify"

class RecommendCycleView: UIView {


    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleTimer : Timer?
    
    var cycleGroups : [CycleModel]? {
        didSet {
            
            collectionView.reloadData()
            pageControl.numberOfPages = cycleGroups?.count ?? 0
            
            let indexPath = IndexPath(item: (cycleGroups?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            removeTimer()
            addCycleTimer()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //让空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellIdentify)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //在layoutSubViews中设置frame相关属性
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .horizontal
        //以上固定属性都可以在xib中设置
    }

}

extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleGroups?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = (indexPath as NSIndexPath).row % (cycleGroups?.count ?? 1)
        let cycleModel = cycleGroups?[row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellIdentify, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModel
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width/2
        let currentIndex = Int(offsetX / scrollView.bounds.width)
        pageControl.currentPage = currentIndex % (cycleGroups?.count ?? 1)
    }
}

extension RecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let cellWidth = collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: currentOffsetX + cellWidth, y: 0), animated: true)
    }
}
