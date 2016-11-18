//
//  UIColor-Extension.swift
//  DouyuSwift
//
//  Created by ToothBond on 16/11/11.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(255)),g: CGFloat(arc4random_uniform(255)),b: CGFloat(arc4random_uniform(255)))
    }
}
