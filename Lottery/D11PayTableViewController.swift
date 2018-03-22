//
//  D11PayTableViewController.swift
//  Lottery
//
//  Created by DTY on 2017/5/9.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11PayTableViewController: PayTableViewController {
    
    var deadlineButton: LotteryDeadlineButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets.zero;
        //截止Label
        self.deadlineButton = LotteryDeadlineButton(frame: CGRect(x: 0, y: 5, width: self.view.frame.width, height: 30));
        self.deadlineButton.isUserInteractionEnabled = false;
        self.tableView.tableHeaderView = self.deadlineButton;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func onCompleteSuccess(service: BaseService) {
        super.onCompleteSuccess(service: service);
        if (service == self.orderBuyService) {
           self.deadlineButton.isUserInteractionEnabled = false;
        }
    }
    
    override func onCompleteFail(service: BaseService) {
        super.onCompleteFail(service: service);
        if (self.betService.currentPeriod == nil) {
            self.deadlineButton.isUserInteractionEnabled = true;
            self.deadlineButton.addTarget(self, action: #selector(getPeriodInfo), for: .touchUpInside);
            self.deadlineTimeInterval = -1;
        }
    }
    
    override func deadlineTimerAction() {
        super.deadlineTimerAction();
        
        let attText = LotteryUtil.getDeadlineContent(timeInterval: self.deadlineTimeInterval, subPeriod: self.betService.currentSubPeriod);
        self.deadlineButton.setAttributedTitle(attText, for: .normal);
        
        if (self.deadlineTimeInterval == 59 || self.deadlineTimeInterval == 1) {
            CommonUtil.vibrate();
        }
    }

}
