//
//  PageTitleView.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/10.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    
    fileprivate var titles : [String]
    
//    fileprivate lazy var scrollView : UIScrollView
//    
//    fileprivate lazy var scrollLine : UIView

    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView {
    fileprivate func setupUI() {
        
        setupTitleLabels()
        
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
    
    }
    
    private func setupBottomLineAndScrollLine() {
    
    }
}
