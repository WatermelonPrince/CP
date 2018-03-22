//
//  FollowDetail.swift
//  Lottery
//
//  Created by DTY on 2017/5/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class FollowDetail: BaseModel {
    var gameId: Int?;
    var gameEn: String?;
    var gameName: String?;
    var gameImageUrl: String?;
    var followId: String?;
    var followStatus: Int?;
    var followStatusCn: String?;
    var amount: Double?;
    var bonus: Double?;
    var followInfo: String?;
    var followModeCn: String?;
    var followOrderVos: Array<FollowOrder>?;
    var prizeStatus: Int?;
}
