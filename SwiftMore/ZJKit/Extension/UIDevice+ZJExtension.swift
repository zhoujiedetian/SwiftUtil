//
//  UIDevice+ZJExtension.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2020/3/24.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import Foundation

extension UIDevice {
    class func isJailBreak() -> Bool {
        if UIApplication.shared.canOpenURL(URL.init(string: "cydia://")!) {
            print("当前设备已经越狱")
            return true
        }
        print("当前设备未越狱")
        return false;
    }
}
