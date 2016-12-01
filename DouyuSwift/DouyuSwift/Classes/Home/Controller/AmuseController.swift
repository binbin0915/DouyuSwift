//
//  AmuseController.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/12/1.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class AmuseController: BaseAnchorContorller {
    
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    
    override func loadData () {
        baseVM = amuseVM
        
        amuseVM.loadData {
            self.collectionView.reloadData()
        }
    }
}

