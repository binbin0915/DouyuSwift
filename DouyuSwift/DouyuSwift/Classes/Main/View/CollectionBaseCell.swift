//
//  CollectionBaseCell.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/17.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
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
            titleLabel.text = anchor.room_name
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            imageView.kf.setImage(with: iconURL)
        }
    }
    
}
