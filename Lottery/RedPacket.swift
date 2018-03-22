//
//  RedPacket.swift
//  Lottery
//
//  Created by DTY on 2017/5/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class RedPacket: BaseModel {
    static let INIT = 0; //待派发
    static let AVAILABLE = 1; //可用
    static let RUNOUT = 2; //已用完
    static let OVERDUE = 3; //已过期
    static let DELETE = -1;
    
    var redPacketId: Int?;
    var userId: Int?;
    var name: String?;
    var description: String?;
    var balance: Double?;
    var amount: Double?;
    var condition: Double?;
    var startTimeContent: String?;
    var validTimeContent: String?;
    var usable: Bool?; //Game
    var gameList: Array<Game>?;
    var status: Int?; //
}
class PayMethod: BaseModel {
    var name: String?;
    var imageUrl: String?;
    var type:Int?
    var paymethod:String?
}
