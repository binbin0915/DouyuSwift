//
//  PageContentView.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/10.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class{
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, startIndex : Int, targetIndex : Int);
}

private let CollectionCellIdentify : String = "ccIdentify"

class PageContentView: UIView {
    
    fileprivate var childVCs : [UIViewController]
    fileprivate var parentViewController : UIViewController
    fileprivate var orginScrollX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    fileprivate var isScrollFromClick : Bool = false
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CollectionCellIdentify)
        
        return collectionView
        
    }()

    init(frame: CGRect, childVCs : [UIViewController], parentViewController: UIViewController) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView {
    fileprivate func setupUI() {
        for child in childVCs {
            parentViewController.addChildViewController(child)
        }
        
        collectionView.frame = self.bounds
        addSubview(collectionView)
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCellIdentify, for: indexPath)
        let childVC = childVCs[indexPath.item]
        print(cell.contentView.bounds)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScrollFromClick = false
        
        orginScrollX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isScrollFromClick {
            return
        }
        
        //判断是左滑 or 右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width;
        
        var progress : CGFloat = 0
        var startIndex : Int = 0
        var targetIndex : Int = 0
        
        if currentOffsetX > orginScrollX {
            //左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW)
            startIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = startIndex + 1
            
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            if currentOffsetX - orginScrollX == scrollViewW {
                progress = 1
                targetIndex = startIndex
            }
        } else {
            //右滑
            progress = (orginScrollX - currentOffsetX)/scrollViewW
            targetIndex = Int(currentOffsetX / scrollViewW)
            startIndex = targetIndex + 1
            
            if startIndex < 0 {
                startIndex = 0
            }
            
            if startIndex >= childVCs.count {
                startIndex = childVCs.count - 1
            }
            
            if orginScrollX - currentOffsetX == scrollViewW {
                progress = 1
                startIndex = targetIndex
            }
        }
//        print("progress = \(progress); startIndex = \(startIndex); targetIndex = \(targetIndex)")
        delegate?.pageContentView(self, progress: progress, startIndex: startIndex, targetIndex: targetIndex)
    }
}

extension PageContentView {
    func setCurrentIndex(_ currentIndex:Int)  {
        isScrollFromClick = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y:0), animated: false)
    }
}
