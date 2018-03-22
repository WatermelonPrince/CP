//
//  Bill.swift
//  Lottery
//
//  Created by DTY on 2017/5/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class Bill: BaseModel {
    var billId: Int?;
    var platformId: String?;
    var accountId: String?;
    var amount: Double?;
    var balance: Double?;
    var type: Int?;
    var typeContent: String?;
    var status: Int?;
    var createTimeContent: String?;
}
