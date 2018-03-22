//
//  LaunchAdService.swift
//  Lottery
//
//  Created by DTY on 2017/5/4.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
//获取广告的请求
class LaunchAdService: BaseService {
    var launchAd: Banner!;
    
    func getAd() {
        self.get(HTTPConstants.SPLASH, parameters: nil) { (json) in
            self.launchAd = Banner.deserialize(from: json["banner"].rawString()!);
            if (self.launchAd != nil) {
                LotteryUtil.saveLaunchAd(launchAd: self.launchAd);
            }
        }
    }
}
