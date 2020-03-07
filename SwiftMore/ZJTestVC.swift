//
//  ZJTestVC.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2020/2/23.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJTestVC: ZJBaseVC {
    var timer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "123"
    }
    
    deinit {
        print(#function)
        timer?.invalidate()
    }
    
    @objc func timerTest() {
        print(#function)
    }
    

    @IBAction func clickButton(_ sender: Any) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: ZJProxy.proxy(withTarget: self), selector: #selector(timerTest), userInfo: nil, repeats: true)
    }
}
