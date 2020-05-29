//
//  BizConstant.swift
//  LBGBlueToothScan
//
//  Created by 精灵要跳舞 on 2019/8/6.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import Foundation

private enum EnvironmentType {
    case EnvironmentTypeIntraNet    //内网
    case EnvironmentTypeOuterNet    //外网
    case EnvironmentTypeTestingNet  //测试
    case EnvironmentTypeFormalNet   //正式
}

#if DEBUG
/// 环境变量
private var environmentArgu = EnvironmentType.EnvironmentTypeTestingNet

var kZJ_URL_Host : String {
    get {
        switch environmentArgu {
            case .EnvironmentTypeIntraNet:
                return "http://172.21.41.6:17223/intra"
            case .EnvironmentTypeOuterNet:
                return "http://172.21.41.6:17223/outer"
            case .EnvironmentTypeTestingNet:
                return "http://172.21.41.6:17223/testing"
            case .EnvironmentTypeFormalNet:
                return "http://172.21.41.6:17223/formal"
        }
    }
}
#else
//正式环境
let kZJ_URL_Host = "http://172.21.41.6:17223/formal"
#endif
