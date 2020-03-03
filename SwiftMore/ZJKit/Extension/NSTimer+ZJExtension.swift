//
//  NSTimer+ZJExtension.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/12/4.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import Foundation
class TimerBlock {
    let f : ((Timer) -> Void)
    init(_ f: @escaping (Timer) -> Void) {
        self.f = f
    }
}

extension Timer {
    
    /// 兼容iOS10以下的版本使用Timer block方法
    /// - Parameters:
    ///   - interval: 时间间隔
    ///   - repeats: 是否重复
    ///   - block: block回掉
    class func weak_ScheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: block)
        }else {
            return Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(weak_TimerAction), userInfo: TimerBlock(block), repeats: repeats)
        }
    }
    
    @objc class func weak_TimerAction(_ sender : Timer) {
        if let block = sender.userInfo as? TimerBlock {
            block.f(sender)
        }
    }
}
