//
//  ZJPermenantThread.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2020/2/23.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJPermenantThread : NSObject {
    
    var innerThread : Thread?
    var isStopped : Bool?
    
    /// 创建一个线程
    override init() {
        super.init()
        createInnerThread()
    }
    
    /// 创建在子线程中完成任务
    /// - Parameter task: 任务
    func excuteTask(task : (()->())?) {
        guard let newTask = task else { return }
        self.perform(#selector(__excuteTask(task:)), on: innerThread!, with: newTask, waitUntilDone: false)
    }
    
    /// 销毁一个线程
    func stop() {
        guard let thread = innerThread else {
            return
        }
        self.perform(#selector(__stop), on: thread, with: nil, waitUntilDone: true)
    }
    
    deinit {
        stop()
    }
    
    private func createInnerThread() {
        isStopped = false
        innerThread = Thread.init(block: { [weak self] in
            RunLoop.current.add(Port(), forMode: .default)
            RunLoop.current.run()
//            if let weakSelf = self {
//                while(!(weakSelf.isStopped!)) {
//                  RunLoop.current.run(mode: .default, before: .distantFuture)
//                }
//            }
        })
        innerThread?.start()
    }
    
    @objc private func __stop() {
        isStopped = true
        CFRunLoopStop(CFRunLoopGetCurrent())
    }
    
    @objc private func __excuteTask(task : ()->()) {
        task()
    }
}
