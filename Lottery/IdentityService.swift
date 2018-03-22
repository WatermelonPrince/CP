//
//  IdentityService.swift
//  Lottery
//
//  Created by DTY on 2017/5/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class IdentityService: BaseService {
    
    var name: String!;
    var identityCard: String!;
    var mobile: String!
    
    func queryIdentity() {
        self.get(HTTPConstants.QUERY_IDENTITY, parameters: nil) { (json) in
            self.name = json["name"].object as? String;
            self.identityCard = json["identityCard"].object as? String;
            self.mobile = json["mobile"].object as? String;
            self.onCompleteSuccess();
        }
    }
    
    func verifyIdentity(mobile: String, name:String, identityCard: String, smsCode: String) {
        var parameters = Dictionary<String, Any>();
        parameters["mobile"] = mobile;
        parameters["name"] = name;
        parameters["identityCard"] = identityCard;
        parameters["smsCode"] = smsCode;
        self.post(HTTPConstants.VERIFY_IDENTITY, encryptParameters: parameters) { (json) in
            self.onCompleteSuccess();
        }
    }

}
