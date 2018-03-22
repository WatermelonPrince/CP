//
//  WithdrawService.swift
//  Lottery
//
//  Created by DTY on 2017/5/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class WithdrawService: BaseService {
    var successTip: String!;
    
    func withdraw(withdrawAmount: String) {
        var parameters = Dictionary<String, Any>();
        parameters["withdrawAmount"] = withdrawAmount;
        self.post(HTTPConstants.WITHDRAW, parameters: parameters) { (json) in
            self.successTip = json["successTip"].object as? String;
            self.onCompleteSuccess();
        }
    }

}
