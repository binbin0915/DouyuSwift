//
//  MainController.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/9.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // 通过Storyboard获取控制器
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func addChildVC(storyName: String) {
        // 通过Storyboard获取控制器
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVC)
    }

}
