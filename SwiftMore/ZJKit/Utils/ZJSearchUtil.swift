//
//  ZJSearchUtil.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2020/2/16.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJSearchUtil {
    /*
     二分查找
     要求查找数组必须为顺序排列（正序或倒序）
     时间复杂度为log2n（以2为底，n的对数）
     */
    class func binarySearch<T : Comparable>(sourceArr : Array<T>, key : T) -> Int? {
        var lowerBound = 0
        var upperBound = sourceArr.count
        while lowerBound < upperBound {
            let midIndex = (lowerBound + upperBound) / 2
            if sourceArr[midIndex] == key {
                return midIndex
            }else if sourceArr[midIndex] > key {
                upperBound = midIndex
            }else {
                lowerBound = midIndex + 1
            }
        }
        return nil
    }
}
