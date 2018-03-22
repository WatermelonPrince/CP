//
//  SSQNormalViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class SSQNormalViewController: DPCNormalViewController {
    
    override func viewDidLoad() {
        self.title = "双色球";
        self.totalRedBalls = 33;
        self.totalBlueBalls = 16;
        self.minRedBalls = 6;
        self.minBlueBalls = 1;
        self.navController = SSQOrderViewController();
        self.navController.gameName = self.gameName;
        self.navController.gameId = self.gameId;
        self.navController.gameEn = self.gameEn;
    
        super.viewDidLoad();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func dropDownButtonChangeAction() {
        LotteryUtil.saveLotterySelectedTypeInt(gameEn: self.gameEn, selectedInt: 0)
    }
    
}
