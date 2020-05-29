//
//  BizConstant.swift
//  LBGBlueToothScan
//
//  Created by 精灵要跳舞 on 2019/8/6.
//  Copyright © 2019 精灵要跳舞. All rights reserved.
//

import Foundation

private enum environmentType {
    case environmentTypeIntraNet    //内网
    case environmentTypeOuterNet    //外网
    case environmentTypeTestingNet  //测试
    case environmentTypeFormalNet   //正式
}

#if DEBUG
/// 环境变量
private var environmentArgu = environmentType.environmentTypeTestingNet

var kZJ_URL_Host : String {
    get {
        switch environmentArgu {
            case .environmentTypeIntraNet:
                return "http://172.21.41.6:17223/intra"
            case .environmentTypeOuterNet:
                return "http://172.21.41.6:17223/outer"
            case .environmentTypeTestingNet:
                return "http://172.21.41.6:17223/testing"
            case .environmentTypeFormalNet:
                return "http://172.21.41.6:17223/formal"
        }
    }
}
#else
//正式环境
let kZJ_URL_Host = "http://172.21.41.6:17223/formal"
#endif
