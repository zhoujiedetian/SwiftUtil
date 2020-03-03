//
//  ZJRouter.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/5/9.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit

extension UIResponder {
    //创建一个路由消息
    @objc func router(withEventName eventName : String, dataInfo : NSDictionary) {
        self.next?.router(withEventName: eventName, dataInfo: dataInfo)
    }
}

