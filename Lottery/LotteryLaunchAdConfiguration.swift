//
//  LotteryLaunchAdConfiguration.swift
//  Lottery
//
//  Created by DTY on 2017/4/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
//广告配置文件
class LotteryLaunchAdConfiguration: XHLaunchImageAdConfiguration {
    
    override init() {
        super.init();
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH*960/640);
        if (LotteryUtil.launchAd()?.imgUrl != nil) {
           self.imageNameOrURLString = (LotteryUtil.launchAd()?.imgUrl)!;
        }
        if (LotteryUtil.launchAd()?.detailUrl != nil) {
            self.openURLString = (LotteryUtil.launchAd()?.detailUrl)!;
        }
        self.duration = 4;
        self.skipButtonType = .text;
        self.showFinishAnimate = .lite;
    }
    
}
