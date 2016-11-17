//
//  CollectionNormalCell.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/14.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: CollectionBaseCell {


    @IBOutlet weak var nickLabel: UILabel!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            
            nickLabel.text = anchor?.nickname

        }
    }
}
