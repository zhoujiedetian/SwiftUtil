//
//  ZJTipView.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/4/25.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit
//动画出现时间
let animationShowDuration = 0.5
//动画消失时间
let animationDismissDuration = 1.5

/// 错误提示框
class ZJTip : NSObject{
    
    /// 黑色背景框
    lazy var blackView : UIView = {
        let blackView = UIView()
        blackView.clipsToBounds = true
        blackView.layer.cornerRadius = 3
        blackView.backgroundColor = UIColor.black
        return blackView
    }()
    
    /// 内容Lab
    lazy var contentLab : UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0;
        return label
    }()
    
    /// 提示框(不带完成回调）
    ///
    /// - Parameter content: 提示框显示的内容
    @objc class func showTip(content : String) {
        ZJTip.showTip(content: content, completion: nil)
    }
    
    /// 提示框（带完成回调）
    ///
    /// - Parameters:
    ///   - content: 提示框显示的内容
    ///   - completion: 完成回调
    @objc class func showTip(content : String, completion : (()->())?) {
        let tip = ZJTip()
        tip.show(content: content, completion: completion)
    }
}

extension ZJTip {
    
    private func show(content : String, completion : (()->())?) {
        contentLab.text = content
        blackView.addSubview(contentLab)
        contentLab.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.lessThanOrEqualTo(300)
        }
        let window = (UIApplication.shared.delegate?.window)!
        window!.addSubview(blackView)
        blackView.snp.makeConstraints { (make) in
            make.center.equalTo(window!)
        }
        showAnimation(completion: completion)
    }
    
    private func showAnimation(completion : (()->())?) {
        blackView.alpha = 0
        UIView.animate(withDuration: animationShowDuration, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            self?.blackView.alpha = 1.0
        }) { (complete) in
            UIView.animate(withDuration: animationDismissDuration, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
                self?.blackView.alpha = 0.0
            }) { [weak self] (isComplete) in
                if completion != nil {
                    completion!()
                }
                self?.blackView.removeFromSuperview()
            }
        }
    }
}
