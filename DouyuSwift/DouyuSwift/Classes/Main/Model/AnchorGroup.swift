//
//  AnchorGroup.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/15.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /**
     "room_list": [],
     "push_vertical_screen": "0",
     "icon_url": "https://staticlive.douyucdn.cn/upload/game_cate/f0a531a7198cac2ba0747c435644d690.jpg",
     "tag_name": "英雄联盟",
     "tag_id": "1"
     
     */
    
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict : dict))
            }
        }
    }
    
    var tag_name : String = ""
    var icon_name : String = "home_header_normal"
    
    var icon_url : String = ""
    
    
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
    
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
