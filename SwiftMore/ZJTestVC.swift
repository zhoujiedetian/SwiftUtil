//
//  ZJTestVC.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2020/2/23.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJTestVC: ZJBaseVC {
    
    var myThread : ZJPermenantThread?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "123"
        myThread = ZJPermenantThread.init()
    }


    @IBAction func clickButton(_ sender: Any) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myThread?.excuteTask(task: {
            print("123" + "\(RunLoop.current)")
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
