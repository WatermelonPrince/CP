//
//  Order.swift
//  Lottery
//
//  Created by DTY on 2017/4/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class Order: BaseModel {

    //OrderStatus
    //0：待支付
    //1：过期未支付
    //2：出票中
    //3：出票中
    //4：退款中
    //41：退款成功
    //42：退款失败
    //5：投注成功
    
    //prizeStatus
    //0：等待开奖
    //1：未中奖
    //2：中奖
    //3：奖金计算中
    //4：中奖

    
    var orderId: String?;
    var followId: String?;
    var createTime: String?;
    var gameId: Int?;
    var gameName: String?;
    var periodId: String?;
    var bonus: Double?;
    var orderAmount: Double?;
    var orderStatus: Int?;
    var prizeStatus: Int?;
    var orderStatusCn: String?;
    var statusCnColor: String?;
    var totalTickets: Int?;
    var successTickets: Int?;
    var remark: String?;
    var commonFlag: Int?;
    var orderType: Int?;
    var orderTypeCn: String?;
    var endTime: String?;
    
}
