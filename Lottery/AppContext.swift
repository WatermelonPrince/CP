//
//  AppContext.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

//APP的配置信息，包括一些配置历史用户信息，

class AppContext: NSObject, ServiceDelegate {
    static let APP_ID = "appId";
    static let APP_KEY = "appKey";
    static let TOKEN = "token";
    
    var appService: AppService?;
    
    func initial() {
        let appId = LotteryUtil.appId();
        let appKey = LotteryUtil.appKey();
        //当appID和appKey丢失重新请求  并存储
        if (appId == nil || appKey == nil) {
            //AppService
            self.appService = AppService(delegate: self);
            self.appService?.initialApp();
        }
    }
    
    func onCompleteSuccess(service: BaseService) {
        LotteryUtil.saveAppId(appId: self.appService?.appInfo?.appId);
        LotteryUtil.saveAppKey(appKey: self.appService?.appInfo.appKey);
    }

}
