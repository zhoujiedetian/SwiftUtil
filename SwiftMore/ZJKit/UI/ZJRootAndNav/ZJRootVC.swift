//
//  ZJRootVC.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/7/1.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJRootVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbar()
    }
}

extension ZJRootVC {
    
    func setUpTabbar() {
        //顶部添加一条自定义分割线
        let lineRect = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 0.5)
        UIGraphicsBeginImageContext(lineRect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.rgbFromHex(rgb: 0xf2f2f2).cgColor)
        context.fill(lineRect)
        let lineImg = UIGraphicsGetImageFromCurrentImageContext()
        self.tabBar.shadowImage = lineImg
        self.tabBar.backgroundImage = UIImage()
        //tabbar背景颜色
        self.tabBar.barTintColor = UIColor.white
        //未选择状态下title属性
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
        //选择状态下title属性
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : kNav_ThemeColor], for: .selected)
        //item图片显示颜色，不设置默认为蓝色
        self.tabBar.tintColor = kNav_ThemeColor
    }
    
    func addChildNav(vc : UIViewController, normalImg : UIImage, selectImg : UIImage, title : String) {
        let nav = ZJNavigationController.init(rootViewController: vc)
        nav.tabBarItem.selectedImage = selectImg
        nav.tabBarItem.image = normalImg
        nav.tabBarItem.title = title
        self.addChild(nav)
    }
}
