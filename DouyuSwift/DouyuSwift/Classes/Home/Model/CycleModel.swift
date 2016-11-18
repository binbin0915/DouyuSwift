//
//  CycleModel.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/18.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title : String = ""
    var pic_url : String = ""
    
    var anchor : AnchorModel?
    
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
