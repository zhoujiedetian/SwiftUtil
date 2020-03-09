//
//  ZJProxy.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2020/3/7.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJProxy: NSObject {
    weak var target : AnyObject?
    class func proxy(withTarget target: AnyObject) -> ZJProxy {
        let proxy = ZJProxy.init()
        proxy.target = target
        return proxy
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return target
    }
    
    
}
