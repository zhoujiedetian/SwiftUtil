//
//  ZJTimer.swift
//  SwiftMore
//
//  Created by zhoujie on 2020/5/29.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJTimer: NSObject, SelfAware {
    static func awake() {
//        static var timers : NSMutableDictionary = NSMutableDictionary()
//        static var semaphore_ : DispatchSemaphore = DispatchSemaphore.init(value: 0)
        print("我只执行了1次")
    }
    
//    func executeTask(startTime: TimeInterval,
//                     interval: TimeInterval,
//                     repeats: Bool,
//                     async: Bool,
//                     task: (()->())? ) -> NSString?{
//        if (task == nil) || startTime < 0 || (interval < 0 && repeats) {
//            return nil
//        }
//        let queue = async ? DispatchQueue.global() : DispatchQueue.init(label: "concurrent", attributes: .concurrent)
//        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
//        timer.schedule(deadline: .now(), repeating: interval, leeway: .microseconds(10))
//    }
}
