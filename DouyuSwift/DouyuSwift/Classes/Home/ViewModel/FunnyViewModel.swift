//
//  FunnyViewModel.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/12/5.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

    func loadFunnyData( finishedCallback : @escaping ()->()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}

