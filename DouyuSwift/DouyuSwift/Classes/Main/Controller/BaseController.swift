//
//  BaseController.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/12/5.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    var contentView : UIView?
    
    lazy var loadingView : UIImageView = {[unowned self] in
        let loadingView = UIImageView(image: UIImage(named: "img_loading_1"))
        loadingView.center = self.view.center
        loadingView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        loadingView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        loadingView.animationDuration = 0.5
        loadingView.animationRepeatCount = LONG_MAX
        return loadingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension BaseController {
    func setupUI() {
        view.addSubview(loadingView)
        
        contentView?.isHidden = true
        loadingView.isHidden = false
        
        loadingView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
        contentView?.isHidden = false
    }
}
