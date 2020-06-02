//
//  BizConstant.swift
//  LBGBlueToothScan
//
//  Created by 精灵要跳舞 on 2019/8/6.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import Foundation

private enum EnvironmentType {
    case intraNet    //内网
    case outerNet    //外网
    case testingNet  //测试
    case formalNet   //正式
}

#if DEBUG
/// 环境变量
private var environmentArgu = EnvironmentType.testingNet

var kZJ_URL_Host : String {
    get {
        switch environmentArgu {
            case .intraNet:
                return "http://172.21.41.6:17223/intra"
            case .outerNet:
                return "http://172.21.41.6:17223/outer"
            case .testingNet:
                return "http://172.21.41.6:17223/testing"
            case .formalNet:
                return "http://172.21.41.6:17223/formal"
        }
    }
}
#else
//正式环境
let kZJ_URL_Host = "http://172.21.41.6:17223/formal"
#endif
