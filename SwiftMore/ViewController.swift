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
        
        let tf = ZJNoThirdKeyBoardTF.init()
        tf.backgroundColor = UIColor.red
        tf.font = UIFont.systemFont(ofSize: 25)
        tf.text = "123"
        tf.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        view.addSubview(tf)
    }
    
    @objc func clickRight() {
        print(ZJSort.quickSort(nums: [49, 38, 65, 97, 23, 22, 76, 1, 5, 8, 2, 0, -1, 22]))
    }
    
    override func router(withEventName eventName: String, dataInfo: NSDictionary) {
        print(dataInfo)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


