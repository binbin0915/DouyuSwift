//
//  CollectionPrettyCell.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/14.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var addressBtn: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            addressBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

}
