//
//  DLTOrderViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DLTOrderViewController: DPCOrderViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "大乐透";
        self.gameEn = "dlt"
        self.totalRedBalls = 35;
        self.totalBlueBalls = 12;
        self.minRedBalls = 5;
        self.minBlueBalls = 2;
        
        //bottomMultipleBarMainView
        self.bottomMultipleBarView = DLTOrderBottomMultipleBarView(frame: CGRect(x: 0, y: self.bottomInfoBarView.frame.minY - 40*2, width: self.view.frame.width, height: 40*3));
        self.view.insertSubview(self.bottomMultipleBarView, belowSubview: self.bottomInfoBarView);
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(addNumberAction), name: NSNotification.Name(rawValue: "AddNumberAction"), object: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "AddNumberAction"), object: nil);
    }

    override func selfSelectionAction() {
        self.navController = DLTMainViewController();
        super.selfSelectionAction();
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ballString = self.ballStringArray[indexPath.row];
        self.navController = DLTMainViewController();
        if (ballString.contains("(")) {
            self.navController.selectedInt = 1;
        } else {
            self.navController.selectedInt = 0;
        }
        self.navController.editBallStringArray = [ballString];
        
        super.tableView(tableView, didSelectRowAt: indexPath);
    }
    
    override func toOrderNumber(ballString: String) -> Int {
        var totalNumber = 0;
        if (ballString.contains("(")) {
            totalNumber = LotteryUtil.totalNumberDLTDantuo(string: ballString);
        } else {
            totalNumber = LotteryUtil.totalNumberDPCNormal(string: ballString, minRedBalls: self.minRedBalls, minBlueBalls: self.minBlueBalls);
        }
        return totalNumber;
    }
    
    func addNumberAction() {
        self.isAddNumber = !self.isAddNumber;
        self.tableView.reloadData();
        self.updateAmountInfo();
    }
}
