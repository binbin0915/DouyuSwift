//
//  GameModel.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/30.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class GameModel: NSObject {
    var tag_name : String = ""
    var icon_url : String = ""
    
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
