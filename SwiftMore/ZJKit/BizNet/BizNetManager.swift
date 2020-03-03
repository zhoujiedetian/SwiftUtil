//
//  BizNetManager.swift
//  LBGBlueToothScan
//
//  Created by 精灵要跳舞 on 2019/8/7.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import Foundation
import Alamofire
import MBProgressHUD

/// 简易封装网络框架
class BizNetManager: NSObject {
    
    class func post(withUrl url: String, Parameters params: Dictionary<String,Any>?, SuccessBlock success:((Dictionary<String, Any>)->())?, FailBlock fail:((Dictionary<String, Any>)->())?) {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type":"application/x-www-form-urlencoded"
        ]
        
        let temp = params
        
        var paramsStr : String = "?"
        for (key, value) in temp! {
            paramsStr = "\(paramsStr)\(key)="
            paramsStr = "\(paramsStr)\(value)&"
        }
        let endIndex = paramsStr.index(paramsStr.endIndex, offsetBy: -1)
        let subStr = paramsStr.prefix(upTo:endIndex)
        let urlStr = KBiz_Url_Host + url + subStr
        
        let window : UIWindow = (UIApplication.shared.delegate?.window!!)!
        MBProgressHUD.showAdded(to: window, animated: true)
        
        Alamofire.request(urlStr, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if let json = response.result.value {
                let result = json as? Dictionary<String, Any>
                MBProgressHUD.hide(for: window, animated: true)
                if result!["code"] as! NSInteger == 0  {
                    if success != nil {
                        success!(result!["data"] as! Dictionary<String, Any>)
                    }
                }else {
                    ZJTip.showTip(content: result!["message"] as! String)
                    if fail != nil {
                        fail!(result as Any as! Dictionary<String, Any>)
                    }
                }
            }
        }
    }
    
    class func get(withUrl url: String, Parameters params: Dictionary<String,Any>?, SuccessBlock success:((Dictionary<String, Any>)->())?, FailBlock fail:((Dictionary<String, Any>)->())?) {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type":"application/x-www-form-urlencoded"
        ]
        
        let temp = params
        
        var paramsStr : String = "?"
        for (key, value) in temp! {
            paramsStr = "\(paramsStr)\(key)="
            paramsStr = "\(paramsStr)\(value)&"
        }
        let endIndex = paramsStr.index(paramsStr.endIndex, offsetBy: -1)
        let subStr = paramsStr.prefix(upTo:endIndex)
        let urlStr = KBiz_Url_Host + url + subStr
        
        let window : UIWindow = (UIApplication.shared.delegate?.window!!)!
        MBProgressHUD.showAdded(to: window, animated: true)
        Alamofire.request(urlStr, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            MBProgressHUD.hide(for: window, animated: true)
            if let json = response.result.value {
                let result = json as? Dictionary<String, Any>
                if result!["code"] as! NSInteger == 0  {
                    if success != nil {
                        success!(result!["data"] as! Dictionary<String, Any>)
                    }
                }else {
                    ZJTip.showTip(content: result!["message"] as! String)
                    if fail != nil {
                        fail!(result as Any as! Dictionary<String, Any>)
                    }
                }
            }else {
                ZJTip.showTip(content: "Unknow Reason")
                if fail != nil {
                    fail!(["reason" : "Unknow Reason"])
                }
            }
        }
    }
}

