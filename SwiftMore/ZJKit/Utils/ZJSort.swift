//
//  ZJSearchUtil.swift
//  SwiftMore
//
//  Created by 精灵要跳舞 on 2020/2/16.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

class ZJSort {
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
    
    
    /// 快排
    /// 时间复杂度为nlog2n
    /// - Parameter nums: 未排序的数组
    class func quickSort(nums: [Int]) -> [Int]{
        var sortedNums = nums
        return quickSort(nums: &sortedNums, low: 0, high: sortedNums.count - 1)
    }
    
    private class func quickSort(nums: inout [Int], low: Int, high: Int) -> [Int]{
        if low >= high {
            return nums
        }
        let index = getIndex(nums: &nums, lowIndex: low, highIndex: high)
        _ = quickSort(nums: &nums, low: 0, high: index - 1)
        _ = quickSort(nums: &nums, low: index + 1, high: high)
        return nums
    }

    private class func getIndex(nums: inout [Int], lowIndex: Int, highIndex: Int) -> Int {
        let key = nums[highIndex]
        var low = lowIndex
        for index in low ... highIndex - 1 {
            if nums[index] < key {
                nums.swapAt(low, index)
                low += 1
            }
        }
        nums[highIndex] = nums[low]
        nums[low] = key
        return low
    }
}
