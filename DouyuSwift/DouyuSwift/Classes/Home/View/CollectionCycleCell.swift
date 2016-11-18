//
//  CollectionCycleCell.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/18.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : CycleModel? {
        didSet {
            guard let cycleModel = cycleModel else { return }
            
            titleLabel.text = cycleModel.title
            let iconURL = URL(string: cycleModel.pic_url)
            imageView.kf.setImage(with: iconURL, placeholder: UIImage(named : "Img_default"))
        }
    }
}
