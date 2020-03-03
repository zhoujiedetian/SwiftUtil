//
//  ZJNavigationController.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/5/29.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJNavigationController: UINavigationController {
    
    //自定义返回按钮
    lazy var backBtn : UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "Icon_Back"), for: .normal)
        btn.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
}

extension ZJNavigationController {
    
    /// 统一设置导航栏样式
    func setNavigationBar() {
        let bar = UINavigationBar.appearance()
        bar.isTranslucent = false
        bar.tintColor = UIColor.white
        //导航栏背景色
        bar.barTintColor = KNav_ThemeColor
        //导航栏标题属性
        bar.titleTextAttributes = [.foregroundColor : UIColor.white,                         .font :                            UIFont.boldSystemFont(ofSize: 18)]
        //去除导航栏下方黑线
        bar.setBackgroundImage(UIImage.init(), for: .default)
        bar.shadowImage = UIImage.init()
        //重写了leftbarItem之后,需要添加如下方法才能重新启用右滑返回
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
        }
        //加载自定义返回btn
        self.navigationBar.addSubview(self.backBtn)
        self.backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(40)
            make.height.equalTo(KNavigationHeight)
        }
    }
    
    /// 重写push方法，判定是否隐藏自定义btn
    ///
    /// - Parameters:
    ///   - viewController: viewController
    ///   - animated: animated
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >= 1 {
            self.backBtn.isHidden = false ;
            //隐藏底部tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    /// 重写pop方法，判定是否隐藏自定义btn
    ///
    /// - Parameter animated: animated
    /// - Returns: viewController
    override func popViewController(animated: Bool) -> UIViewController? {
        if self.viewControllers.count == 2 {
            self.backBtn.isHidden = true
        }
        return super.popViewController(animated: animated)
    }
    
    /// 自定义返回btn点击事件
    @objc func tapBack() {
       let _ = self.popViewController(animated: true)
    }
}

extension ZJNavigationController : UIGestureRecognizerDelegate{
    //禁用第一个viewcontroller的测滑返回手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if self.viewControllers.count < 2 ||
               self.visibleViewController == self.viewControllers.first {
                return false
            }
        }
        return true
    }
}
