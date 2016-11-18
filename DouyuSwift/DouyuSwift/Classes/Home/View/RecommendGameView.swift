//
//  RecommendGameView.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/17.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class RecommendGameView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //让空间不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
    }

}

extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
