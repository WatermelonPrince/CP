//
//  D11DantuoRenxuanViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/29.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11DantuoRenxuanViewController: D11DantuoViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.isRenxuan = true;
        
        if (self.prizeContent == "0") {
            self.prizeContent = LotteryUtil.d11MinBallsToPrizeContent(minBalls: self.minBalls);
        } else {
            self.setDescriptionLabel();
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func machineSelectionBasicAction(count: Int) {
        super.machineSelectionBasicAction(count: count);
        for _ in 0..<count {
            self.newBallStringArray.append(LotteryUtil.randomStringD11Renxuan(minBalls: self.minBalls));
        }
        self.navAction();
    }
    
    override func dropDownButtonChangeAction() {
        (self.navController as! D11OrderViewController).d11Type = LotteryUtil.intToD11RenxuanType(int: self.minBalls);
        LotteryUtil.saveLotterySelectedTypeInt(gameEn: self.gameEn, selectedInt: 12 + self.minBalls - 2);
    }
    
    override func setDescriptionLabel() {
        if (self.descriptionLabel == nil) {
            return;
        }
        var subDescriptionString = ""
        switch self.minBalls {
        case 1,2,3,4:
            subDescriptionString = "至少选\(self.minBalls)个号,猜对任意\(self.minBalls)个开奖号即中";
        case 5:
            subDescriptionString = "至少选\(self.minBalls)个号,猜对全部\(self.minBalls)个开奖号即中";
        case 6,7,8:
            subDescriptionString = "至少选\(self.minBalls)个号,选号包含5个开奖号即中";
        default:
             print("选中数目有误")
        }
        let descriptionAttString = LotteryUtil.toDescriptionAttString(subString: subDescriptionString, prizeContent: self.prizeContent);
        self.descriptionLabel.attributedText = descriptionAttString;
    }


}
