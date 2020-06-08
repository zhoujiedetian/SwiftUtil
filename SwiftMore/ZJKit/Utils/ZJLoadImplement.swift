//
//  ZJLoadImplement.swift
//  SwiftMore
//
//  Created by zhoujie on 2020/6/1.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit
/*
 需要在AppDelegate中添加如下代码
 
 extension UIApplication {
     private static let runOnce: Void = {
         NothingToSeeHere.harmlessFunction()
     }()

     static func loadImplement() {
         UIApplication.runOnce
     }
 }
 
 并在 application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool 中调用 UIApplication.loadImplement()
 
 需要使用的类，继承SelfAware协议，并实现awake方法，在awake方法中实现自己需要的功能
 */
protocol SelfAware: class {
    static func awake()
}


/// 用于替换load与initialnize
class NothingToSeeHere {

    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let safeTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(safeTypes, Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SelfAware.Type)?.awake() }
        types.deallocate()
    }
}
