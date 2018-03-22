//
//  DLTMainViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/15.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DLTMainViewController: DPCMainViewController {

    override func viewDidLoad() {
        self.gameEn = "dlt"
        self.childVCs = [DLTNormalViewController(), DLTDantuoViewController()];
        self.gameNameArray = ["普通投注", "胆拖投注"];
        self.titleNameArray = ["大乐透", "大乐透胆拖"];
        
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
