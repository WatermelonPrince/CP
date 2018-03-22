//
//  NoticeService.swift
//  Lottery
//
//  Created by DTY on 2017/4/25.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class NoticeService: BaseService {
    var awardInfoList: Array<AwardInfo>!;
    
    func getNotice() {
        self.getNotice(gameEn: nil);
    }
    
    func getNotice(gameEn: String?) {
        self.get(HTTPConstants.NOTICE, urlParameters: gameEn) { (json) in
            self.awardInfoList = [AwardInfo].deserialize(from: json["awardList"].rawString()) as? Array<AwardInfo>;
            self.onCompleteSuccess();
        }
        
    }
}
