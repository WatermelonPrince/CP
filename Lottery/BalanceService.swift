//
//  BalanceService.swift
//  Lottery
//
//  Created by DTY on 2017/5/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class BalanceService: BaseService {
    var accountBalance: Double = 0.00;
    var withdrawBalance: Double = 0.00;
    var freezeAmount: Double = 0.00;
    var redPacketCount: Int = 0;
    var hasIdentity: Bool!;
    var hasBankCard: Bool!;
    var withdrawMinAmount: Int = 10;
    var withdrawMaxCount: Int = 3;

    
    func getBalance() {
        self.get(HTTPConstants.BALANCE, parameters: nil) { (json) in
            let accountBalance = json["accountBalance"].object as? String;
            if (accountBalance != nil) {
                self.accountBalance = Double(accountBalance!)!;
            }
            
            let withdrawBalance = json["withdrawBalance"].object as? String;
            if (withdrawBalance != nil) {
                self.withdrawBalance = Double(withdrawBalance!)!;
            }
            
            let redPacketCount = json["redPacketCount"].object as? Int;
            if (redPacketCount != nil) {
                self.redPacketCount = redPacketCount!;
            }
            
            let hasIdentity = json["hasIdentity"].object as? Bool;
            if (hasIdentity != nil) {
                self.hasIdentity = hasIdentity!;
            }
            
            let hasBankCard = json["hasBankCard"].object as? Bool;
            if (hasBankCard != nil) {
                self.hasBankCard = hasBankCard!;
            }
            
            let freezeAmount = json["freezeAmount"].object as? String;
            if (freezeAmount != nil) {
                self.freezeAmount = Double(freezeAmount!)!;
            }
            let withdrawMinAmount = json["withdrawMinAmount"].object as? Int;
            if (withdrawMinAmount != nil){
                self.withdrawMinAmount = withdrawMinAmount!
            }
            let withdrawMaxCount = json["withdrawMaxCount"].object as? Int;
            if (withdrawMaxCount != nil){
                self.withdrawMaxCount = withdrawMaxCount!
            }
            
            self.onCompleteSuccess();
        }
    }

}
