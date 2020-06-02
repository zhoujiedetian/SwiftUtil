//
//  ZJTimer.swift
//  SwiftMore
//
//  Created by zhoujie on 2020/5/29.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJTimer: NSObject {
    
    static var timers_ : NSMutableDictionary = NSMutableDictionary()
    static var semaphore_ : DispatchSemaphore = DispatchSemaphore.init(value: 1)
    
    /// 开启一个GCD Timer
    /// - Parameters:
    ///   - startTime: 开始时间
    ///   - interval: 间隔时间
    ///   - repeats: 是否重复
    ///   - async: 同步或异步
    ///   - task: 执行task
    /// - Returns: timerID
    class func executeTask(startTime: TimeInterval,
                     interval: TimeInterval,
                     repeats: Bool,
                     async: Bool,
                     task: (()->())?) -> String? {
        if (task == nil) || startTime < 0 || (interval < 0 && repeats) {
            return nil
        }
        let queue = async ? DispatchQueue.global() : DispatchQueue.main
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        semaphore_.wait()
        let timeId = String.init(format: "%d", timers_.count)
        timers_[timeId] = timer
        semaphore_.signal()
        timer.schedule(deadline: .now() + startTime, repeating: interval, leeway: .microseconds(10))
        timer.setEventHandler {
            if let event = task {
                event()
            }
        }
        timer.resume()
        return timeId
    }
    
    /// 销毁一个timer
    /// - Parameter timeId: timerID
    class func invalidateTimer(timeId: String) {
        if timeId.isEmpty {
           return
        }
        semaphore_.wait()
        if let timer = timers_[timeId] as? DispatchSourceTimer {
            timer.cancel()
            timers_.removeObject(forKey: timeId)
        }
        semaphore_.signal()
    }
}
