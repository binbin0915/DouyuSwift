//
//  CollectionHeaderView.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/14.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var group : AnchorGroup? {
        didSet {
            guard let group = group else { return }
            titleLabel.text = group.tag_name
            iconImage.image = UIImage(named: group.icon_name ?? "home_header_normal")
        }
    }
}
