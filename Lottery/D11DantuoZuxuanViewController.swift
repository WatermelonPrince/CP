//
//  D11DantuoZuxuanViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/29.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11DantuoZuxuanViewController: D11DantuoViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.isRenxuan = false;
        if (self.prizeContent == "0") {
            if (self.minBalls == 2) {
                self.prizeContent = "65";
            } else if (self.minBalls == 3) {
                self.prizeContent = "195";
            }
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
            self.newBallStringArray.append(LotteryUtil.randomStringD11Zuxuan(minBalls: self.minBalls));
        }
        self.navAction();
    }
    
    override func dropDownButtonChangeAction() {
        (self.navController as! D11OrderViewController).d11Type = .qian2Zuxuan;
        if (self.minBalls == 3) {
            (self.navController as! D11OrderViewController).d11Type = .qian3Zuxuan;
        }

        LotteryUtil.saveLotterySelectedTypeInt(gameEn: self.gameEn, selectedInt: 19 + self.minBalls - 2);
    }
    
    override func setDescriptionLabel() {
        if (self.descriptionLabel == nil) {
            return;
        }
        
        let subDescriptionString = "猜对前\(self.minBalls)个开奖号即中";
        let descriptionAttString = LotteryUtil.toDescriptionAttString(subString: subDescriptionString, prizeContent: self.prizeContent);
        self.descriptionLabel.attributedText = descriptionAttString;    }

}
