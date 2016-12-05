//
//  FunnyController.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/12/5.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class FunnyController: BaseAnchorContorller {
    
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
    

}

extension FunnyController {
    
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
    }
    
    override func loadData() {
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
        }
    }
}
