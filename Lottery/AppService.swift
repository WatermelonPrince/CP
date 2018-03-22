//
//  AppService.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class AppService: BaseService {
    
    var appInfo: AppInfo!;
    
    func initialApp() {
        var parameters = Dictionary<String, String>();
        parameters["deviceType"] = "iPhone_\(UIDevice.current.systemName)";
        parameters["sourceChannel"] = "AppStore";
        parameters["systemName"] = "iOS";
        parameters["systemVersion"] = UIDevice.current.systemVersion;
        parameters["productVersion"] = CommonUtil.currentProductVersion();
        parameters["uniqueId"] = UIDevice.current.identifierForVendor?.uuidString;
        
        self.post(HTTPConstants.INITIAL, parameters: parameters) { (json) in
            self.appInfo = AppInfo();
            self.appInfo.appId = json["appId"].object as? String;
            self.appInfo.appKey = json["key"].object as? String;
            self.onCompleteSuccess();
        }
    }
}
