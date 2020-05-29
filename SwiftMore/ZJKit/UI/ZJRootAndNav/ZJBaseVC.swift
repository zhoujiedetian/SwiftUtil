//
//  ZJBaseVC.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/5/28.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJBaseVC: UIViewController {
    
//    lazy var zj_NavigationBar : UINavigationBar = {
//        let navBar = UINavigationBar.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: statusAndNavHeight))
//        navBar.backgroundColor = UIColor.random()
//        return navBar
//    }()
//
//    lazy var zj_NavItem = UINavigationItem.init()
    
//    override var title: String? {
//        didSet {
//            zj_NavItem.title = title
//        }
//    }
//    public typealias btnAttribute = (title: String, attribute: [NSAttributedString.Key : Any], event: Selector?)
    
    /// 默认标题属性
    lazy var btnTitleAttribute : Dictionary = {
        [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.white]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ZJBaseVC {
    
    /// 页面布局
    func setUpView() {
        
        self.view.backgroundColor = UIColor.white
        //隐藏原生返回按钮
        let hideLeft = UIBarButtonItem.init(title: nil, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        hideLeft.width = -10
        self.navigationItem.leftBarButtonItem = hideLeft
    }
    
    /// 设置默认属性的右侧btn
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - event: 点击事件
    @objc func setRightBtn(withTitle title: String, EventResponse event: Selector?) {
        setRightBtn(withTitle: title, Attribute: btnTitleAttribute, EventResponse: event)
    }
    
    /// 设置默认属性的左侧btn
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - event: 点击事件
    @objc func setLeftBtn(withTitle title: String, EventResponse event: Selector?) {
        setLeftBtn(withTitle: title, Attribute: btnTitleAttribute, EventResponse: event)
    }
    
    /// 设置右侧btn
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - attribute: 标题属性
    ///   - event: 点击事件
    @objc func setRightBtn(withTitle title: String, Attribute attribute: Dictionary<NSAttributedString.Key, Any>, EventResponse event: Selector?) {
        setBtn(withTitle: title, Attribute: attribute, EventResponse: event, Image: nil, IsLeft: false)
    }
    
    /// 设置左侧btn
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - attribute: 标题属性
    ///   - event: 点击事件
    @objc func setLeftBtn(withTitle title: String, Attribute attribute: Dictionary<NSAttributedString.Key, Any>, EventResponse event: Selector?) {
        setBtn(withTitle: title, Attribute: attribute, EventResponse: event, Image: nil, IsLeft: true)
    }
    
    /// 设置右侧图片btn
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - event: 点击事件
    @objc func setRightBtn(withImage image: UIImage, EventResponse event: Selector?) {
        setBtn(withTitle: nil, Attribute: nil, EventResponse: event, Image: image, IsLeft: false)
    }
    
    /// 设置左侧图片btn
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - event: 点击事件
    @objc func setLeftBtn(withImage image: UIImage, EventResponse event: Selector?) {
        setBtn(withTitle: nil, Attribute: nil, EventResponse: event, Image: image, IsLeft: true)
    }
    
//    /// 设置右侧多个btn
//    ///
//    /// - Parameter tuples: btn属性元组
//    func setRightBtns(withBtnTuples tuples: Array<btnAttribute>) {
//        var items = Array<UIBarButtonItem>()
//        for tuple in tuples {
//            let item = UIBarButtonItem.init(title: tuple.title, style: .plain, target: self, action: tuple.event)
//            item.setTitleTextAttributes(tuple.attribute, for: .normal)
//            items.append(item)
//        }
//        self.navigationItem.rightBarButtonItems = items
//    }
    
//    /// 设置左侧多个btn
//    ///
//    /// - Parameter tuples: btn属性元组
//    func setLeftBtns(withBtnTuples tuples: Array<(title: String, attribute: [NSAttributedString.Key : Any], event: Selector?)>) {
//        var items = Array<UIBarButtonItem>()
//        for tuple in tuples {
//            let item = UIBarButtonItem.init(title: tuple.title, style: .plain, target: self, action: tuple.event)
//            item.setTitleTextAttributes(tuple.attribute, for: .normal)
//            items.append(item)
//        }
//        self.navigationItem.leftBarButtonItems = items
//    }
}

extension ZJBaseVC {
    private func setBtn(withTitle title: String?, Attribute attribute: Dictionary<NSAttributedString.Key, Any>?, EventResponse event: Selector?, Image image: UIImage?, IsLeft isLeft: Bool) {
        var barBtn : UIBarButtonItem
        if image != nil {
            //图片
            barBtn = UIBarButtonItem.init(image: image, style: .plain, target: self, action: event)
        }else{
            //文字
            barBtn = UIBarButtonItem.init(title: title, style: .plain, target: self, action: event)
        }
        if isLeft {
            self.navigationItem.leftBarButtonItem = barBtn
        }else {
            self.navigationItem.rightBarButtonItem = barBtn
        }
    }
}
