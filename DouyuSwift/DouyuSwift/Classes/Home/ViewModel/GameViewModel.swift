//
//  GameViewModel.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/18.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class GameViewModel {
    
    lazy var games:[AnchorGroup] = [AnchorGroup]()
    
    func requestData(_ finishedCallback : @escaping () -> ()) {
        
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.games.append(AnchorGroup(dict : dict))
            }
            
            finishedCallback()
        }
    }
}
