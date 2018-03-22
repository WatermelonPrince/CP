//
//  BankCardService.swift
//  Lottery
//
//  Created by DTY on 2017/5/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class BankCardService: BaseService {
    var name: String!;
    var bankCardContent: String!;
    var submitSuccess = false;
    
    func queryBankCard() {
        self.get(HTTPConstants.QUERY_BANK_CARD, parameters: nil) { (json) in
            self.name = json["name"].object as? String;
            let bankName = json["bankName"].object as? String;
            let bankCardNumber = json["bankCardNumber"].object as? String;
            if (bankName != nil && bankCardNumber != nil) {
                self.bankCardContent = bankName! + "(" + bankCardNumber! + ")";
            } else if (bankCardNumber != nil) {
                self.bankCardContent = bankCardNumber!;
            }
            self.onCompleteSuccess();
        }
    }
    
    func bindBankCard(bankCardNumber: String) {
        var parameters = Dictionary<String, Any>();
        parameters["bankCardNumber"] = bankCardNumber;
        self.post(HTTPConstants.BIND_BANK_CARD, encryptParameters: parameters) { (json) in
            self.submitSuccess = true;
            self.onCompleteSuccess();
        }
    }

}
