//
//  PrepayService.swift
//  Lottery
//
//  Created by DTY on 2017/5/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PrepayService: BaseService {
    var accountBalance: Double = 0.00;
    var redPacketList = Array<RedPacket>();
    var payMethodList = Array<PayMethod>();

    func getPrepayInfo(gameId: Int?, orderAmount: Double, isFollow: Bool) {
        self.getPrepayInfo(gameId: gameId, orderAmount: orderAmount, isFollow: isFollow, orderId: nil);
    }
    
    func getPrePayInfo(orderId: String) {
        self.getPrepayInfo(gameId: nil, orderAmount: nil, isFollow: nil, orderId: orderId);
    }
    
    func getPrepayInfo(gameId: Int?, orderAmount: Double?, isFollow: Bool?, orderId: String?) {
        ViewUtil.showProgressToast(text: "正在检查红包...");
        var parameters = Dictionary<String,Any>();
        parameters["gameId"] = gameId;
        parameters["orderAmount"] = orderAmount;
        parameters["isFollow"] = isFollow;
        parameters["orderId"] = orderId;
        self.get(HTTPConstants.PREPAY, parameters: parameters) { (json) in
            ViewUtil.dismissToast();
            let accountBalance = json["accountBalance"].object as? String;
            if (accountBalance != nil) {
                self.accountBalance = Double(accountBalance!)!;
            }
            let redPacketList = [RedPacket].deserialize(from: json["redPacketList"].rawString()!) as? Array<RedPacket>;
            let payMethodList = [PayMethod].deserialize(from: json["paymethodList"].rawString()!) as?
                Array<PayMethod>
            if (redPacketList != nil) {
                self.redPacketList = redPacketList!;
            }
            if (payMethodList != nil){
                self.payMethodList = payMethodList!;
            }
            self.onCompleteSuccess();
        }
    }

}
