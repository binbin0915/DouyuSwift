//
//  HomeController.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/10.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeController: UIViewController {
    
    fileprivate lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["","","",""]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.red
        return titleView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()

    }

}

extension HomeController {
    fileprivate func setupUI() {
        
        setupNavigationBar()
        
        
        
        view.addSubview(pageTitleView)
        
    }
    
    fileprivate func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
    
    
}
