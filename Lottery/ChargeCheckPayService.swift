//
//  ChargeCheckPayService.swift
//  Lottery
//
//  Created by DTY on 2017/5/27.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ChargeCheckPayService: BaseService {
    var isPaid: Bool!;
    
    func checkChargePay(chargeId: String) {
        var parameters = Dictionary<String, Any>();
        parameters["chargeId"] = chargeId;
        self.get(HTTPConstants.CHECK_CHARGE_PAY, parameters: parameters) { (json) in
            let isPaid = json["paid"].bool;
            if (isPaid != nil) {
                self.isPaid = isPaid;
            }
            self.onCompleteSuccess();
        }
        
    }

}
