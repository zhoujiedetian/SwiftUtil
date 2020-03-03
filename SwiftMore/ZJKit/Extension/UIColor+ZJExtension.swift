//
//  ZJColor.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/5/14.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit

extension UIColor {
    //16进制转换颜色
    @objc class func rgbFromHex(rgb : Int) -> UIColor {
        return UIColor.rgbaFromHex(rgb: rgb, alpha: 1)
    }
    //16进制转换颜色
    @objc class func rgbaFromHex(rgb : Int, alpha : CGFloat) -> UIColor {
        return UIColor.init(red: CGFloat((rgb & 0xFF0000)>>16) / 255.0, green: CGFloat((rgb & 0xFF00)>>8) / 255.0, blue: CGFloat(rgb & 0xFF) / 255.0, alpha: alpha)
    }
    //随机生成一个颜色
    @objc class func random() -> UIColor {
        return UIColor.init(red: CGFloat(arc4random() % 256) / 255.0, green: CGFloat(arc4random() % 256) / 255.0, blue: CGFloat(arc4random() % 256) / 255.0, alpha: 1)
    }
}
