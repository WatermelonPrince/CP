//
//  OrderCheckPayService.swift
//  Lottery
//
//  Created by DTY on 2017/5/27.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderCheckPayService: BaseService {
    var isPaid: Bool!;//订单是否支付
    
    func checkOrderPay(orderId: String) {
        var parameters = Dictionary<String, Any>();
        parameters["orderId"] = orderId;

        self.get(HTTPConstants.ORDER_CHECK_ORDER_PAY, parameters: parameters, success: { (json) in
                        let isPaid = json["paid"].bool;
                        if (isPaid != nil) {
                            self.isPaid = isPaid;
                        }
                        self.onCompleteSuccess();
            
        }) { (json) -> Bool in
            
        ViewUtil.showToast(text: json["retDesc"].string!);
        ViewUtil.keyViewController().navigationController?.popToRootViewController(animated: true);
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MineViewController.userStatusChangeNotificationName), object: nil);
        self.onCompleteFail();
        return true;
       }
    }

}


