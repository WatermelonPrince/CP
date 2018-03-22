//
//  OrderDetail.swift
//  Lottery
//
//  Created by DTY on 2017/4/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderDetail: BaseModel {
    var orderId: String?;
    var userCode: String?;
    var gameId: Int?;
    var gameEn: String?;
    var gameName: String?;
    var gameImageUrl: String?;
    var periodId: String?;
    var winningNumbers: String?;
    var bonus: Double?;
    var orderAmount: Double?;
    // orderStatus   0：待支付1：过期未支付2：出票中3：出票中4：退款中41：退款成功42：退款失败5：投注成功
    var orderStatus: Int?;
    var prizeStatus: Int?;
    var orderStatusCn: String?;
    var prizeStatusCn: String?;
    var betTimes: Int?;
    var betNumbers: Int?;
    var lotteryNumVoList: Array<LotteryNum>?;
    var totalTickets: Int?;
    var successTickets: Int?;
    var trueAmount: Double?;
    var timeNameStr: String?;
    var timeValueStr: String?;
    var orderTimeStr: String?;
    var remark: String?;
    var periodSaleEndTime: String?;
    var saleEndTime: Int?;
    var ifShowTicket: Int?;
    var ifShowPay: Int?;
    var betInfo: String?;
    var prompt: String?;
    var refundAmount: Double?;
    var refundingAmount: Double?;
    var postStationName: String?;
    var commonFlag: Int?;
    var ifShowRefundDesc: Int?;
    var endTime: String?;
    var awardTime: String?;
    var awardTimeValue: String?;
    var winningNumberColor: String?;
    var bonusTitle: String?;
    var bonusColor: String?;
    var bonusStr: String?;
    var orderType: Int?;
    var orderTypeCn: String?;
    var followDetail: FollowDetail?;
}
