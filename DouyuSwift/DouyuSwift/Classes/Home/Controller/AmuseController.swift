//
//  AmuseController.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/12/1.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200


class AmuseController: BaseAnchorContorller {
    
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsetsMake(kMenuViewH, 0, 0, 0)
    }
    
    override func loadData () {
        baseVM = amuseVM
        
        amuseVM.loadData {
            self.collectionView.reloadData()
            
            var tempArr = self.amuseVM.anchorGroups
            tempArr.removeFirst()
            self.menuView.groups = tempArr
        }
    }
}

