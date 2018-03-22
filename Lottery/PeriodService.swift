//
//  PeriodService.swift
//  Lottery
//
//  Created by DTY on 2017/4/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PeriodService: BaseService {
    var periodList: Array<Period>!;
    
    func getPeriods() {
        
        self.get(HTTPConstants.PERIODS, parameters: nil) { (json) in
            self.periodList = [Period].deserialize(from: json["periodList"].rawString()) as? Array<Period>;
            self.onCompleteSuccess();
        }
    }

}
