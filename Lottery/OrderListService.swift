//
//  OrderListService.swift
//  Lottery
//
//  Created by DTY on 2017/5/9.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderListService: BaseService {
    var orderList = Array<Order>();
    var orderdetail: OrderDetail!;
    var page = 1;
    var hasNextPage: Bool?;
    
    func getOrderList(status: Int?) {
        self.getOrderList(page: nil, status: status);
    }
    
    func getOrderList(page: Int?, status: Int?) {
        var parameters = Dictionary<String, Any>();
        parameters["page"] = page;
        parameters["status"] = status;
        self.get(HTTPConstants.ORDER_LIST, parameters: parameters) { (json) in
            let orderList = [Order].deserialize(from: json["orderList"].rawString()!) as? Array<Order>;
            if (orderList != nil) {
                if (page == nil) {
                    self.orderList = orderList!;
                    self.page = 1;
                } else {
                    self.orderList = self.orderList + orderList!;
                    self.page = self.page + 1;
                }
                self.hasNextPage = json["paginator"]["hasNextPage"].bool;
            }
            
            self.onCompleteSuccess();
        }
    }
    
    func getOrderDetail(orderId: String) {
        var parameters = Dictionary<String, Any>();
        parameters["orderId"] = orderId;
        self.get(HTTPConstants.ORDER_DETAIL, parameters: parameters) { (json) in
            self.orderdetail = OrderDetail.deserialize(from: json["orderDetail"].rawString()!);
            self.onCompleteSuccess();
        }
    }

}
