//
//  CollectionPrettyCell.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/14.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressBtn: UIButton!

    @IBOutlet weak var onlineLabel: UILabel!
    
    var anchor : AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            
            titleLabel.text = anchor.room_name
            addressBtn.setTitle(anchor.anchor_city, for: .normal)
            var onlineStr = ""
            if anchor.online > 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineLabel.text = onlineStr
            
            guard let imageURL = URL(string: anchor.vertical_src) else { return }
            imageView.kf.setImage(with: imageURL)
        }
    }

}
