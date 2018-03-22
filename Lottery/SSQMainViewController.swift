//
//  SSQMainViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/10.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class SSQMainViewController: DPCMainViewController {

    override func viewDidLoad() {
        self.gameEn = "ssq";
        self.childVCs = [SSQNormalViewController(), SSQDantuoViewController()];
        self.gameNameArray = ["普通投注", "胆拖投注"];
        self.titleNameArray = ["双色球", "双色球胆拖"];
        
        if (self.editBallStringArray.count == 0) {
            let selectedInt = LotteryUtil.lotterySelectedTypeInt(gameEn: self.gameEn);
            if (selectedInt != nil) {
                self.selectedInt = selectedInt!;
            }
        }
        
        super.viewDidLoad();

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
