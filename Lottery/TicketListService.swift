//
//  TicketListService.swift
//  Lottery
//
//  Created by DTY on 2017/5/23.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class TicketListService: BaseService {
    var ticketList = Array<Ticket>();
    var page = 1;
    var hasNextPage: Bool?;
    
    func getTicketList(orderId: String) {
        self.getTicketList(page: nil, orderId: orderId);
    }
    
    func getTicketList(page: Int?, orderId: String) {
        var parameters = Dictionary<String, Any>();
        parameters["page"] = page;
        parameters["orderId"] = orderId
        self.get(HTTPConstants.TICKET_DETAIL, parameters: parameters) { (json) in
            let ticketList = [Ticket].deserialize(from: json["ticketList"].rawString()!) as? Array<Ticket>;
            if (ticketList != nil) {
                if (page == nil) {
                    self.ticketList = ticketList!;
                    self.page = 1;
                } else {
                    self.ticketList = self.ticketList + ticketList!;
                    self.page = self.page + 1;
                }
                self.hasNextPage = json["paginator"]["hasNextPage"].bool;
            }
            
            self.onCompleteSuccess();
        }
    }

}
