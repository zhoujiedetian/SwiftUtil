//
//  ZJUIView.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/10/20.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 绝对布局
    /// - Parameter corner: 圆角方向
    /// - Parameter cornerRadius: 圆角大小
    func addCorners(corner: UIRectCorner, cornerRadius: CGSize) {
        let bezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: cornerRadius)
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
    }
}
