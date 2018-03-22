//
//  DLTNormalViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DLTNormalViewController: DPCNormalViewController {

    override func viewDidLoad() {
        self.title = "大乐透";
        self.totalRedBalls = 35;
        self.totalBlueBalls = 12;
        self.minRedBalls = 5;
        self.minBlueBalls = 2;
        
        super.viewDidLoad();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func navAction() {
        self.navController = DLTOrderViewController();
        self.navController.gameName = self.gameName;
        self.navController.gameId = self.gameId;
        self.navController.gameEn = self.gameEn;
        super.navAction();
    }
    
    override func dropDownButtonChangeAction() {
        LotteryUtil.saveLotterySelectedTypeInt(gameEn: self.gameEn, selectedInt: 0);
    }
    

}
