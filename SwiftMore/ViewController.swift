//
//  ViewController.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2019/4/18.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import UIKit

class ViewController: ZJBaseVC {
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "首页"
        self.setRightBtn(withTitle: "这是啥", EventResponse: #selector(clickRight))
        
        var count = 0;
        let timerID = ZJTimer.executeTask(startTime: 5, interval: 1, repeats: true, async: true) {
            count += 1
            print("\(count)")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            ZJTimer.invalidateTimer(timeId: timerID!)
        }
    }
    
    @objc func clickRight() {
        
    }
    
    override func router(withEventName eventName: String, dataInfo: NSDictionary) {
        print(dataInfo)
    }
}

