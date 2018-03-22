//
//  FeedbackService.swift
//  Lottery
//
//  Created by zhaohuan on 2017/8/7.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class FeedbackService: BaseService {
    
    
    func commitFeedback(userId:String,mobile:String?,name:String?,email:String?,message:String) {
        let parameters = ["userId":userId,"mobile":mobile,"name":name,"email":email,"message":message];
        self.get(HTTPConstants.FEEDBACK, parameters: parameters) { (json) in
            self.onCompleteSuccess();
        }
    }

}


