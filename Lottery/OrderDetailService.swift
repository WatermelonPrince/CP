//
//  OrderDetailService.swift
//  Lottery
//
//  Created by DTY on 2017/5/15.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderDetailService: BaseService {
    var orderDetail: OrderDetail!;
    
    func getOrderDetail(orderId: String) {
        var parameters = Dictionary<String, Any>();
        parameters["orderId"] = orderId;
        self.get(HTTPConstants.ORDER_DETAIL, parameters: parameters) { (json) in
            let orderDetail = OrderDetail.deserialize(from: json["orderDetail"].rawString()!);
            if (orderDetail != nil) {
               self.orderDetail = orderDetail!;
            }
            self.onCompleteSuccess();
        }
    }

}
