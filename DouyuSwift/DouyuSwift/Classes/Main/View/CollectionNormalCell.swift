//
//  CollectionNormalCell.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/14.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var onlineLabel: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            
            onlineLabel.setTitle(onlineStr, for: .normal)
            nickLabel.text = anchor.nickname
            
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            imageView.kf.setImage(with: iconURL)
        }
    }
}
