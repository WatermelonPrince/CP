//
//  DPCBaseViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/14.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

enum DPCType {
    case normal;
    case dantuo;
}

class DPCBaseViewController: LotteryBoardBaseViewController {
    var totalRedBalls = 0;
    var totalBlueBalls = 0;
    var minRedBalls = 0;
    var minBlueBalls = 0;
        
    override func viewDidLoad() {
        super.viewDidLoad();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func machineSelectionBasicAction(count: Int) {
        super.machineSelectionBasicAction(count: count);
        for _ in 0..<count {
            self.newBallStringArray.append(LotteryUtil.randomStringDPCNormal(totalRed: self.totalRedBalls, minRed: self.minRedBalls, totalBlue: self.totalBlueBalls, minBlue: self.minBlueBalls));
        }
        self.navAction();
    }
    
    func navAction() {
        //如果有订单页则返回并添加新的cell
        for viewController in (self.navigationController?.viewControllers)! {
            if (viewController.isKind(of: DPCOrderViewController().classForCoder)) {
                self.navController = viewController as! DPCOrderViewController;
                _ = self.navigationController?.popViewController(animated: true);
                if (self.editBallStringArray.count > 0) {
                    //修改
                    self.navController.ballStringArray[self.navController.editedRow] = self.editBallStringArray[0];
                    
                    self.navController.tableView.reloadData();
                } else {
                    //添加
                    self.navController.insertRows(newArray: self.newBallStringArray);
                }
                return;
            }
        }
        
        //没有订单页则创建
        self.navController.insertRows(newArray: self.newBallStringArray);
        self.pushViewController(viewController: self.navController);
    }

}
