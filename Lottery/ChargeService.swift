//
//  ChargeService.swift
//  Lottery
//
//  Created by DTY on 2017/5/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ChargeService: BaseService {
    var chargeId: String!;
    var payUrl: String!;
        
    func charge(chargeAmount: Double, paymethod: String) {
        var parameters = Dictionary<String, Any>();
        parameters["chargeAmount"] = chargeAmount;
        parameters["paymethod"] = paymethod;
        self.post(HTTPConstants.CHARGE, parameters: parameters) { (json) in
            self.chargeId = json["chargeId"].string;
            self.payUrl = json["payUrl"].string;
            self.onCompleteSuccess();
        }
    }

}
