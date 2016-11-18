//
//  RecommendViewModel.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/15.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleGroups : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()

}

extension RecommendViewModel {
    func requestData(_ finishedCallback : @escaping () -> ()) {
        let parameters = ["limit" : "4",
                          "offset" : "0",
                          "time" : Date.getCurrentTime()]
        
        //分组，三个请求成功回调后，统一处理
        let dGroup = DispatchGroup()
        
        //第一部分推荐数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict : dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        
        //第二部分推荐数据
        dGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict : dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        
        //游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1479192120
        
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
//            print("result = \(result)")
            
            guard let resultDict = result as? [String : NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                let group = AnchorGroup(dict : dict)
                self.anchorGroups.append(group)
            }
            
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishedCallback()
        }
    }
    
    
    
    /// 请求推荐轮播数据
    ///
    /// - parameter finishedCallback: 请求成功回调
    func requestCycleData(_ finishedCallback : @escaping ()->()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            guard let resultDict = result as? [String : NSObject] else { return }
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            for dict in dataArray {
                let cycle = CycleModel(dict: dict)
                self.cycleGroups.append(cycle)
            }
            
            finishedCallback()
        }
    }
}
