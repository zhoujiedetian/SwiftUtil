//
//  ZJAlert.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/4/18.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit


/// 提示弹框
class ZJAlert : NSObject {
    
    /// 显示正常提示框
    ///
    /// - Parameters:
    ///   - vc: 显示的控制器
    ///   - content: 内容
    ///   - sureAction: 确认操作
    @objc class func showNormal(in vc : UIViewController, content : String, sureAction : (()->())?) {
        let alert = UIAlertController(title: "温馨提示", message: content, preferredStyle: .alert);
        let cancel = UIAlertAction(title: "取消", style: .default, handler: nil) ;
        let sure = UIAlertAction(title: "确认", style: .default) { (action) in
            if sureAction != nil {
                sureAction!()
            }
        }
        alert.addAction(cancel)
        alert.addAction(sure)
        vc.present(alert, animated: true, completion: nil)
    }
    
    /// 显示只带确认的提示框
    ///
    /// - Parameters:
    ///   - vc: 显示的控制器
    ///   - content: 内容
    @objc class func showSureOnly(in vc : UIViewController, content : String) {
        self.showSureOnly(in: vc, content: content, sureAction: nil)
    }
    
    /// 显示只带确认的提示框（带确认操作）
    ///
    /// - Parameters:
    ///   - vc: 显示的控制器
    ///   - content: 内容
    ///   - sureAction: 确定调用的方法
    @objc class func showSureOnly(in vc : UIViewController, content : String, sureAction : (()->())?) {
        let alert = UIAlertController.init(title: "温馨提示", message: content, preferredStyle: .alert);
        let sure = UIAlertAction(title: "确认", style: .default) { (action) in
            if sureAction != nil {
                sureAction!()
            }
        }
        alert.addAction(sure)
        vc.present(alert, animated: true, completion: nil)
    }
}
