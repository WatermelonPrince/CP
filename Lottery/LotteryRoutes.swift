//
//  LotteryRoutes.swift
//  Lottery
//
//  Created by DTY on 2017/4/14.
//  Copyright © 2017年 caipiao. All rights reserved.
//
////  根据url跳转到指定控制器，前提是该url在HostRouter中作过注册处理


import UIKit
class LotteryRoutes: JLRoutes {
    
    static func routeURLString(_ URLString: String) {
        LotteryRoutes.routeURLString(URLString, withParameters: nil);
    }
    
    static func routeURLString(_ URLString: String, withParameters parameters: [AnyHashable : Any]!) {
        self.routeURL(CommonUtil.getURL(URLString), withParameters: parameters);
    }
    
    static func routeLogin() {
        LotteryRoutes.routeURLString(HostRouter.LOGIN);
    }

}
