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
    }
    
    @objc func clickRight() {
        print(ZJSort.quickSort(nums: [49, 38, 65, 97, 23, 22, 76, 1, 5, 8, 2, 0, -1, 22]))
    }
    
    override func router(withEventName eventName: String, dataInfo: NSDictionary) {
        print(dataInfo)
    }
}


