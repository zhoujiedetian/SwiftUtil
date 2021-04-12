//
//  UITextField.swift
//  SwiftMore
//
//  Created by zhoujie on 2021/4/12.
//  Copyright © 2021 精灵要跳舞. All rights reserved.
//

import UIKit

extension UITextField {
    func selectedRange() -> NSRange? {
        guard let selectedStart = selectedTextRange?.start, let selectedEnd = selectedTextRange?.end else {
            return nil
        }
        let location = offset(from: beginningOfDocument, to: selectedStart)
        let length = offset(from: selectedStart, to: selectedEnd)
        return NSMakeRange(location, length)
    }
    
    func setSelectedRange(range : NSRange) {
        guard let start = position(from: beginningOfDocument, offset: range.location),
              let end = position(from: beginningOfDocument, offset: range.location + range.length) else {
            return
        }
        let selectedRange = textRange(from: start, to: end)!
        selectedTextRange = selectedRange
    }
}
