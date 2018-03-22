//
//  OrderToPayService.swift
//  Lottery
//
//  Created by zhaohuan on 2017/7/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderToPayService: BaseService {
    
    var orderId: String!;
    var paymentOrderId: String!;
    var amount: String!;
    var orderType: Int!;//1.普通2.追号
    var payUrl: String?;
    
    func continueToPay(orderId: String?, paymethod: String?) {
        ViewUtil.showProgressToast();
        var parameters = Dictionary<String, Any>();
        parameters["orderId"] = orderId;
        parameters["paymethod"] = paymethod;
        parameters["client"] = 1 //IOS=1
        self.post(HTTPConstants.ORDER_CONTINUE_PAY, parameters: parameters, success: { (json) in
            self.orderId = json["orderId"].string;
            self.paymentOrderId = json["paymentOrderId"].string;
            self.amount = json["amount"].string;
            self.orderType = json["orderType"].int;
            self.payUrl = json["payUrl"].string;
            self.onCompleteSuccess();
        }) { (json) -> Bool in
            ViewUtil.dismissToast();
            let retCode = json["retCode"].int;
            if (retCode == 416 || retCode == 620 || retCode == 417) {
                let alertController = UIAlertController(title: json["retDesc"].string!, message: nil, preferredStyle: .alert);
                alertController.addAction(UIAlertAction(title: "好的", style: .default, handler: { (action) in
                    ViewUtil.keyViewController().navigationController?.popToRootViewController(animated: true);
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: MineViewController.userStatusChangeNotificationName), object: nil);
                }));
                alertController.show();
            } else {
                ViewUtil.showToast(text: json["retDesc"].string!);
                ViewUtil.keyViewController().navigationController?.popToRootViewController(animated: true);
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: MineViewController.userStatusChangeNotificationName), object: nil);
            }
            self.onCompleteFail();
            return true;
        }
        
    }

}
