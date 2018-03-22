//
//  OrderBuyService.swift
//  Lottery
//
//  Created by DTY on 2017/5/2.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderBuyService: BaseService {
    
    var orderId: String!;
    var paymentOrderId: String!;
    var amount: String!;
    var orderType: Int!;//1.普通2.追号
    
    var currentPeriodId: String?;
    
    var payUrl: String?;
    
    func orderAdd(gameId: Int?, periodId: String?, betTimes: Int?, lotteryNumber: String?, amount: Double?, balancePay: Double?, needPay: Double?, paymethod: String?, gameExtra: String?, redPacketId: Int?) {
        ViewUtil.showProgressToast();
        var parameters = Dictionary<String, Any>();
        parameters["gameId"] = gameId;
        parameters["periodId"] = periodId;
        parameters["betTimes"] = betTimes;
        parameters["lotteryNumber"] = lotteryNumber;
        parameters["amount"] = amount;
        parameters["balancePay"] = balancePay;//余额
        parameters["needPay"] = needPay; 
        parameters["paymethod"] = paymethod;
        parameters["gameExtra"] = gameExtra;
        parameters["client"] = 1 //IOS=1
        parameters["redPacketId"] = redPacketId;
        
        self.post(HTTPConstants.ORDER_ADD, parameters: parameters, success: { (json) in
            self.orderId = json["orderId"].string;
            self.paymentOrderId = json["paymentOrderId"].string;
            self.amount = json["amount"].string;
            self.orderType = json["orderType"].int;
            self.payUrl = json["payUrl"].string;
            self.onCompleteSuccess();
        }) { (json) -> Bool in
            ViewUtil.dismissToast();
            let retCode = json["retCode"].int;
            if (retCode == 410) {
                if (self.currentPeriodId != nil) {
                    let alertController = UIAlertController(title: "期次改变提示", message: "第\(periodId!)期已截止，当前是第\(self.currentPeriodId!)期，确定继续投注？", preferredStyle: .alert);
                    alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
                    alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
                        self.orderAdd(gameId: gameId, periodId: self.currentPeriodId!, betTimes: betTimes, lotteryNumber: lotteryNumber, amount: amount, balancePay: balancePay, needPay: needPay, paymethod: paymethod, gameExtra: gameExtra, redPacketId: redPacketId);
                    }));
                    alertController.show();
                }
                
            } else {
                ViewUtil.showToast(text: json["retDesc"].string!);
            }
            self.onCompleteFail();
            return true;
        }
    }
    
    func followBuy(gameId: Int?, followMode: Int?, followType: Int?,totalPeriod: Int?, periodId: String?, betTimes: Int?, lotteryNumber: String?, amount: Double?, balancePay: Double?, needPay: Double?, paymethod: String?, gameExtra: String?, redPacketId: Int?) {
        ViewUtil.showProgressToast();
        var parameters = Dictionary<String, Any>();
        parameters["gameId"] = gameId;
        parameters["followMode"] = followMode;
        parameters["followType"] = followType;
        parameters["totalPeriod"] = totalPeriod;
        parameters["periodTimesStr"] = periodId! + "_" + String(describing: betTimes!);
        parameters["lotteryNumber"] = lotteryNumber;
        parameters["amount"] = amount;
        parameters["balancePay"] = balancePay;
        parameters["needPay"] = needPay;
        parameters["paymethod"] = paymethod;
        parameters["gameExtra"] = gameExtra;
        parameters["client"] = 1 //IOS=1
        parameters["redPacketId"] = redPacketId;
        
        self.post(HTTPConstants.FOLLOW_BUY, parameters: parameters, success: { (json) in
            self.orderId = json["orderId"].string;
            self.paymentOrderId = json["paymentOrderId"].string;
            self.amount = json["amount"].string;
            self.orderType = json["orderType"].int;
            self.payUrl = json["payUrl"].string;
            self.onCompleteSuccess();
        }) { (json) -> Bool in
            ViewUtil.dismissToast();
            let retCode = json["retCode"].int;
            if (retCode == 410) {
                if (self.currentPeriodId != nil) {
                    let alertController = UIAlertController(title: "期次改变提示", message: "第\(periodId!)期已截止，当前是第\(self.currentPeriodId!)期，确定继续投注？", preferredStyle: .alert);
                    alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
                    alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
                        self.orderAdd(gameId: gameId, periodId: self.currentPeriodId!, betTimes: betTimes, lotteryNumber: lotteryNumber, amount: amount, balancePay: balancePay, needPay: needPay, paymethod: paymethod, gameExtra: gameExtra, redPacketId: redPacketId);
                    }));
                    alertController.show();
                }
            } else {
                ViewUtil.showToast(text: json["retDesc"].string!);
            }
            self.onCompleteFail();
            return true;
        }
    }
    
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
            }
            self.onCompleteFail();
            return true;
        }
        
    }

}
