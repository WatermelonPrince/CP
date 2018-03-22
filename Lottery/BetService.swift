//
//  BetService.swift
//  Lottery
//
//  Created by DTY on 2017/4/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class BetService: BaseService {
    var currentPeriod: Period!;
    var currentSubPeriod: String!;
    var lastSubPeriod: String!;
    var awardInfoMap: Dictionary<String, String>!;
    var awardInfoVos: Array<AwardInfo>!;
    var lastAwardInfo: AwardInfo!;
    var periodAllTime: Int!;
    var poolBonus: String!;
    var beitou: String!;
    var gameType: Int!;
    var betEndInfo: String!;
    
    func getPeriods(gameEn: String) {
        self.get(HTTPConstants.BET, urlParameters: gameEn) { (json) in
            self.currentPeriod = Period.deserialize(from: json["currentPeriod"].rawString());
            self.currentSubPeriod = json["currentSubPeriod"].string;
            self.lastSubPeriod = json["lastSubPeriod"].string;
            self.awardInfoMap = json["awardInfoMap"].dictionaryObject as! Dictionary<String, String>;
            self.awardInfoVos = [AwardInfo].deserialize(from: json["awardInfoVos"].rawString()) as? Array<AwardInfo>;
            self.lastAwardInfo = AwardInfo.deserialize(from: json["lastAwardInfo"].rawString());
            self.periodAllTime = json["periodAllTime"].int;
            self.poolBonus = json["poolBonus"].string;
            self.beitou = json["beitou"].string;
            self.gameType = json["gameType"].int;
            self.betEndInfo = json["betEndInfo"].string;
            self.onCompleteSuccess();
        }
    }

}
