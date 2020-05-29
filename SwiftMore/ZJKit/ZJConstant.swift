//
//  ZJConstant.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/4/25.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
//MARK:高度相关
/// 状态栏高度
var kStatusBarHeight : CGFloat {
    get {
        if #available(iOS 13.0, *) {
            let sceneArr = UIApplication.shared.connectedScenes
            let windowScene = sceneArr.first as! UIWindowScene
            return windowScene.statusBarManager?.statusBarFrame.size.height ?? 0
        }else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
}
/// 导航栏高度
let kNavigationHeight : CGFloat = 44.0
/// 整体导航栏高度
let kStatusAndNavHeight = kNavigationHeight + kStatusBarHeight
/// 底部安全高度
let kSafeBottomHeight : CGFloat = 34.0
/// 屏幕宽
let kScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕高
let kScreenHeight = UIScreen.main.bounds.size.height

//MARK:颜色相关
/// 主题颜色，根据需求自己定义
let kNav_ThemeColor = UIColor.rgbFromHex(rgb: 0xab0032)

//MARK:机型相关
/// 是否为刘海屏
var isIphoneX : Bool {
    get {
        if #available(iOS 11.0, *) {
            return (kKeyWindow.safeAreaInsets.bottom > 0)
        }else {
            return false
        }
    }
}

/// app名称
let kAppName = Bundle.main.infoDictionary!["CFBundleName"] as? String

/// 主window
var kKeyWindow : UIWindow {
    get {
        if #available(iOS 13.0, *) {
            let sceneArr = UIApplication.shared.connectedScenes
            let windowScene = sceneArr.first as! UIWindowScene
            let window = windowScene.windows.last
            return window!
        }else {
            return UIApplication.shared.keyWindow!
        }
    }
}
