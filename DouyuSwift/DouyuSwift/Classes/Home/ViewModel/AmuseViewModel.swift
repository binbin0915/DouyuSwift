//
//  AmuseViewModel.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/12/1.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
    
    
}

extension AmuseViewModel {
    func loadData( finishedCallback : @escaping ()->()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") {
            finishedCallback()
        }
    }
}
