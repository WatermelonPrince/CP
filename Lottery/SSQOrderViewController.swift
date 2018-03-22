//
//  SSQOrderViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class SSQOrderViewController: DPCOrderViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "双色球";
        self.gameEn = "ssq";
        self.totalRedBalls = 33;
        self.totalBlueBalls = 16;
        self.minRedBalls = 6;
        self.minBlueBalls = 1;
        
        //bottomMultipleBarMainView
        self.bottomMultipleBarView = SSQOrderBottomMultipleBarView(frame: CGRect(x: 0, y: self.bottomInfoBarView.frame.minY - 40*2, width: self.view.frame.width, height: 40*3));
        self.view.insertSubview(self.bottomMultipleBarView, belowSubview: self.bottomInfoBarView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func selfSelectionAction() {
        self.navController = SSQMainViewController();
        super.selfSelectionAction();
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ballString = self.ballStringArray[indexPath.row];
        self.navController = SSQMainViewController();
        if (ballString.contains("(")) {
            self.navController.selectedInt = 1;
        } else {
            self.navController.selectedInt = 0;
        }
        self.navController.editBallStringArray.removeAll();
        self.navController.editBallStringArray.append(ballString);
        
        super.tableView(tableView, didSelectRowAt: indexPath);
    }
    
    override func toOrderNumber(ballString: String) -> Int {
        var totalNumber = 0;
        if (ballString.contains("(")) {
            totalNumber = LotteryUtil.totalNumberSSQDantuo(string: ballString);
        } else {
            totalNumber = LotteryUtil.totalNumberDPCNormal(string: ballString, minRedBalls: self.minRedBalls, minBlueBalls: self.minBlueBalls);
        }
        return totalNumber;
    }
    
}
