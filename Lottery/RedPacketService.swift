//
//  RedPacketService.swift
//  Lottery
//
//  Created by DTY on 2017/5/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class RedPacketService: BaseService {
    var redPacketList = Array<RedPacket>();
    var page = 1;
    var hasNextPage: Bool?;
    
    func getRedPacketList(status: Int) {
        self.getRedPacketList(status: status, page: nil);
    }
    
    func getRedPacketList(status: Int, page: Int?) {
        self.getRedPacketList(status: status, page: page, gameId: nil);
    }
    
    func getRedPacketList(status: Int, page: Int?, gameId: String?) {
        var parameters = Dictionary<String,Any>();
        parameters["status"] = status;
        parameters["page"] = page;
        parameters["gameId"] = gameId;
        self.get(HTTPConstants.RED_PACKET_LIST, parameters: parameters) { (json) in
            let redPacketList = [RedPacket].deserialize(from: json["redPacketList"].rawString()!) as? Array<RedPacket>;
            if (redPacketList != nil) {
                if (page == nil) {
                    self.redPacketList = redPacketList!;
                    self.page = 1;
                } else {
                    self.redPacketList = self.redPacketList + redPacketList!;
                    self.page = self.page + 1;
                }
                self.hasNextPage = json["paginator"]["hasNextPage"].bool;
            }
            self.onCompleteSuccess();
        }
    }
    
}
