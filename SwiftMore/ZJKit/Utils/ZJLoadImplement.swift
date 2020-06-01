//
//  ZJLoadImplement.swift
//  SwiftMore
//
//  Created by zhoujie on 2020/6/1.
//  Copyright © 2020 精灵要跳舞. All rights reserved.
//

import UIKit

protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere {

    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let safeTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(safeTypes, Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SelfAware.Type)?.awake() }
        types.deallocate()
    }
}
