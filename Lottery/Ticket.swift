//
//  Ticket.swift
//  Lottery
//
//  Created by DTY on 2017/5/23.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class Ticket: BaseModel {
    var ticketId: String?;
    var ticketStatus: Int?;
    var ticketStatusCn: String?;
    var prizeStatusCn: String?;
    var extraCn: String?;
    var times: Int?;
    var bonus: Double?;
    var orderId: String?;
    var prizeStatus: Int?;
    var ticketNo: Bool?;
    var lotteryNumbers: Array<String>?;
    var ifPassPeriod: Bool?;
}
