//
//  CollectionGameCell.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/18.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            
            let iconURL = URL(string: group?.icon_url ?? "")
            iconView.kf.setImage(with: iconURL, placeholder: UIImage(named : "home_more_btn"))
        }
    }

}
