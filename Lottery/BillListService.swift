//
//  BillListService.swift
//  Lottery
//
//  Created by DTY on 2017/5/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class BillListService: BaseService {
    var billList = Array<Bill>();
    var page = 1;
    var hasNextPage: Bool?;
    
    func getBillList() {
        self.getBillList(page: nil);
    }
    
    func getBillList(page: Int?) {
        var parameters = Dictionary<String, Any>();
        parameters["page"] = page;
        self.get(HTTPConstants.BILL_LIST, parameters: parameters) { (json) in
            let billList = [Bill].deserialize(from: json["billList"].rawString()!) as? Array<Bill>;
            if (billList != nil) {
                if (page == nil) {
                    self.billList = billList!;
                    self.page = 1;
                } else {
                    self.billList = self.billList + billList!;
                    self.page = self.page + 1;
                }
                self.hasNextPage = json["paginator"]["hasNextPage"].bool;
            }
            self.onCompleteSuccess();
        }
    }

}
