//
//  PageTitleView.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/10.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index : Int)
}

private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
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
        
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabels()
        
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels() {
        
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - kScrollLineH
        
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            label.frame = CGRect(x: labelW * CGFloat(index), y: 0, width: labelW, height: labelH)
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tapGes)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: frame.width, height: 0.5)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

extension PageTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        
        guard let currentLabel = tapGes.view as? UILabel else { return}
        
        let oldLabel = titleLabels[currentIndex]
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
        
    }
}

extension PageTitleView {
    func setTitleWithProgress(_ progress: CGFloat, startIndex:Int, targetIndex:Int)  {
        let startLabel = titleLabels[startIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - startLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = startLabel.frame.origin.x + moveX
        
        let colorDelta = (kSelectedColor.0 - kNormalColor.0,kSelectedColor.1 - kNormalColor.1,kSelectedColor.2 - kNormalColor.2)
        startLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}
