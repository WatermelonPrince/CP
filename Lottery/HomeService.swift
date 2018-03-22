//
//  HomeService.swift
//  Lottery
//
//  Created by DTY on 2017/4/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class HomeService: BaseService {
    var bannerList: Array<Banner>!;
    var cornerBanner: Banner!;
    var gameEntranceList: Array<Entrance>!;
    var hotTitle: String!;
    var hotTips: String!
    var hotGamePeriod: Period!;
    
    func getHome() {
        self.get(HTTPConstants.HOME, parameters: nil) { (json) in
            self.bannerList = [Banner].deserialize(from: json["banners"].rawString()!) as? Array<Banner>;
            self.cornerBanner = Banner.deserialize(from: json["cornerBanner"].rawString()!);
            self.gameEntranceList = [Entrance].deserialize(from: json["gameEntrances"].rawString()!) as? Array<Entrance>;
            if (json["hotGamePeriods"].arrayObject?.count != 0) {
                let firstHotGamePeriodDict = json["hotGamePeriods"].arrayObject?[0] as? Dictionary<String, Any>;
                self.hotTitle = firstHotGamePeriodDict?["hotTitle"] as? String;
                self.hotTips = firstHotGamePeriodDict?["hotTips"] as? String;
                if (self.hotTips.isEmpty) {
                    self.hotTips = "福地惊爆720万大奖2元豪揽！"
                }
                let hotGamePeriodDict = firstHotGamePeriodDict?["periodVo"] as? Dictionary<String, Any>;
                self.hotGamePeriod = Period.deserialize(from: hotGamePeriodDict as NSDictionary?);
            }
            self.onCompleteSuccess();
        }
    }

}
