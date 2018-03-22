//
//  D11OrderViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

enum D11Type{
    case renxuan2;
    case renxuan3;
    case renxuan4;
    case renxuan5;
    case renxuan6;
    case renxuan7;
    case renxuan8;
    case qian1;
    case qian2Zhixuan;
    case qian2Zuxuan;
    case qian3Zhixuan;
    case qian3Zuxuan;
}

class D11OrderViewController: LotteryOrderViewController {
    var d11Type : D11Type = .renxuan2;
    
    var deadlineButton: LotteryDeadlineButton!;
    var deadlineTimer: Timer?;
    var deadlineTimeInterval: TimeInterval = MAX_TIME_INTERVAL;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if (self.gameName.isEmpty) {
            self.title = "11选5";
        } else {
            self.title = self.gameName;
        }
        
        //截止Label
        self.deadlineButton = LotteryDeadlineButton(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 25));
        self.deadlineButton.backgroundColor = COLOR_WHITE;
        self.view.insertSubview(self.deadlineButton, belowSubview: self.maskButton);
        
        //TableView位置
        self.topButtonsView.frame.origin.y += 25;
        self.tableHorizontalLine.frame.origin.y += 25;
        self.tableView.frame.origin.y += 25;
        self.tableView.frame.size.height -= 25;

        //bottomMultipleBarMainView
        self.bottomMultipleBarView = D11OrderBottomMultipleBarView(frame: CGRect(x: 0, y: self.bottomInfoBarView.frame.minY - 40*2, width: self.view.frame.width, height: 40*3));
        self.view.insertSubview(self.bottomMultipleBarView, belowSubview: self.bottomInfoBarView);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.deadlineTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(deadlineTimerAction), userInfo: nil, repeats: true);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.deadlineTimer?.invalidate();
        self.deadlineTimer = nil;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func machineSelectionAction() {
        super.machineSelectionAction();
        var selectedInt = LotteryUtil.lotterySelectedTypeInt(gameEn: self.gameEn);
        if (selectedInt == nil) {
            selectedInt = 0
        }
        self.d11Type = LotteryUtil.selectedIntToD11Type(int: selectedInt!);
        
        if (String(describing: self.d11Type).contains("renxuan")) {
            let int = LotteryUtil.d11RenxuanTypeToInt(type: self.d11Type);
           self.insertRows(newArray: [LotteryUtil.randomStringD11Renxuan(minBalls: int)]);
        } else if (self.d11Type == .qian1) {
            self.insertRows(newArray: [LotteryUtil.randomStringD11Qian1()]);
        } else if (self.d11Type == .qian2Zhixuan) {
            self.insertRows(newArray: [LotteryUtil.randomStringD11Qian2Zhixuan()]);
        } else if (self.d11Type == .qian2Zuxuan) {
            self.insertRows(newArray: [LotteryUtil.randomStringD11Zuxuan(minBalls: 2)]);
        } else if (self.d11Type == .qian3Zhixuan) {
            self.insertRows(newArray: [LotteryUtil.randomStringD11Qian3Zhixuan()]);
        } else if (self.d11Type == .qian3Zuxuan) {
            self.insertRows(newArray: [LotteryUtil.randomStringD11Zuxuan(minBalls: 3)]);
        }
        
    }
    
    override func updateAmountInfo() {
        var orderNumber = 0;
        for string in self.ballStringArray.enumerated() {
            orderNumber = orderNumber + self.toOrderNumber(ballString: string.element);
        }
        var termNumber = 1;
        let termText = self.bottomMultipleBarView.mainView.termTextField.text;
        if (termText != nil && Int(termText!) != nil) {
            termNumber = Int(termText!)!;
        }
        var multipleNumber = 1;
        let multipleText = self.bottomMultipleBarView.mainView.multipleTextField.text;
        if (multipleText != nil && Int(multipleText!) != nil) {
            multipleNumber = Int(multipleText!)!;
        }
        let amount = orderNumber * termNumber * multipleNumber * 2;
        
        self.bottomInfoBarView.setData(orderNumber: orderNumber, termNumer: termNumber, multipleNumer: multipleNumber, amount: amount);
    }

    override func selfSelectionAction() {
        self.navController = D11MainViewController();
        super.selfSelectionAction();
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ballString = self.ballStringArray[indexPath.row];
        self.navController = D11MainViewController();
        var selectedInt = 0;
        if (ballString.contains("(")) {//胆拖
            if (ballString.contains(LotteryUtil.RENXUAN)) {
                var content = ballString;
                content.characters.removeLast();
                let intChar = content.characters.last!;
                let int = Int(String(describing: intChar))!;
                selectedInt = 12 + int - 2;
            } else if (ballString.contains(LotteryUtil.QIAN_2_ZUXUAN)) {
                selectedInt = 19;
            } else if (ballString.contains(LotteryUtil.QIAN_3_ZUXUAN)) {
                selectedInt = 20;
            }
        } else {
            if (ballString.contains(LotteryUtil.RENXUAN)) {
                var content = ballString;
                content.characters.removeLast();
                let intChar = content.characters.last!;
                let int = Int(String(describing: intChar))!;
                selectedInt = int - 2
            } else if (ballString.contains(LotteryUtil.QIAN_1)) {
                selectedInt = 7;
            } else if (ballString.contains(LotteryUtil.QIAN_2_ZHIXUAN)) {
                selectedInt = 8;
            } else if (ballString.contains(LotteryUtil.QIAN_2_ZUXUAN)) {
                selectedInt = 9;
            } else if (ballString.contains(LotteryUtil.QIAN_3_ZHIXUAN)) {
                selectedInt = 10;
            } else if (ballString.contains(LotteryUtil.QIAN_3_ZUXUAN)) {
                selectedInt = 11;
            }
            
        }
        
        self.navController.selectedInt = selectedInt;
        self.navController.editBallStringArray.removeAll();
        self.navController.editBallStringArray.append(ballString);
        
        self.tableView?.deselectRow(at: indexPath, animated: true);
        self.editedRow = indexPath.row;
        self.pushViewController(viewController: self.navController)
    }
    
    override func toCellDetailString(ballString: String) -> String {
        var descriptionString = "";
        let totalNumber = self.toOrderNumber(ballString: ballString);
        
        var d11TypeString = "";
        if (ballString.contains(LotteryUtil.RENXUAN)) {
            var content = ballString;
            content.characters.removeLast();
            let intChar = content.characters.last!;
            let int = Int(String(describing: intChar))!;
            d11TypeString = "任选\(CommonUtil.toChineseNumber(number: int))";
        } else if (ballString.contains(LotteryUtil.QIAN_1)) {
            d11TypeString = "前一";
        } else if (ballString.contains(LotteryUtil.QIAN_2_ZHIXUAN)) {
            d11TypeString = "前二直选";
        } else if (ballString.contains(LotteryUtil.QIAN_2_ZUXUAN)) {
            d11TypeString = "前二组选";
        } else if (ballString.contains(LotteryUtil.QIAN_3_ZHIXUAN)) {
            d11TypeString = "前三直选";
        } else if (ballString.contains(LotteryUtil.QIAN_3_ZUXUAN)) {
            d11TypeString = "前三组选";
        }
        descriptionString.append(d11TypeString);
        
        if (ballString.contains("(")) {
            descriptionString.append("胆拖");
        }
        
        let amount = totalNumber*2;
        descriptionString.append(" \(totalNumber)注 \(amount)元");
        return descriptionString;
    }
    
    override func toOrderNumber(ballString: String) -> Int {
        var totalNumber = 0;
        if (ballString.contains("(")) {//胆拖
            if (ballString.contains(LotteryUtil.RENXUAN)) {
                var content = ballString;
                content.characters.removeLast();
                let intChar = content.characters.last!;
                let int = Int(String(describing: intChar))!;
                totalNumber = LotteryUtil.totalNumberD11Dantuo(string: ballString, minBalls: int);
            } else if (ballString.contains(LotteryUtil.QIAN_2_ZUXUAN)) {
                totalNumber = LotteryUtil.totalNumberD11Dantuo(string: ballString, minBalls: 2);
            } else if (ballString.contains(LotteryUtil.QIAN_3_ZUXUAN)) {
                totalNumber = LotteryUtil.totalNumberD11Dantuo(string: ballString, minBalls: 3);
            }
        } else {
            if (ballString.contains(LotteryUtil.RENXUAN)) {
                var content = ballString;
                content.characters.removeLast();
                let intChar = content.characters.last!;
                let int = Int(String(describing: intChar))!;
                totalNumber = LotteryUtil.totalNumberD11Renxuan(string: ballString, minBalls: int)
            } else if (ballString.contains(LotteryUtil.QIAN_1)) {
                totalNumber = LotteryUtil.totalNumberD11Qian1(string: ballString);
            } else if (ballString.contains(LotteryUtil.QIAN_2_ZHIXUAN)) {
                totalNumber = LotteryUtil.totalNumberD11Qian2Zhixuan(string: ballString);
            } else if (ballString.contains(LotteryUtil.QIAN_2_ZUXUAN)) {
                totalNumber = LotteryUtil.totalNumberD11Zuxuan(string: ballString);
            } else if (ballString.contains(LotteryUtil.QIAN_3_ZHIXUAN)) {
                totalNumber = LotteryUtil.totalNumberD11Qian3Zhixuan(string: ballString);
            } else if (ballString.contains(LotteryUtil.QIAN_3_ZUXUAN)) {
                totalNumber = LotteryUtil.totalNumberD11Zuxuan(string: ballString);
            }
        }
        return totalNumber;
    }
    
    override func getPeriodInfo() {
        super.getPeriodInfo();
        self.deadlineTimeInterval = MAX_TIME_INTERVAL;
    }
    
    override func onCompleteSuccess(service: BaseService) {
        super.onCompleteSuccess(service: service);
        let endTime = self.betService.currentPeriod.saleEndTime;
        if (endTime != nil) {
            self.deadlineTimeInterval = Double(endTime!);
        }
        self.deadlineButton.isUserInteractionEnabled = false;
        
        (self.bottomMultipleBarView.termView as! D11OrderBottomMultipleBarTermView).setData(maxTimes: 84);
    }
    
    func onCompleteFail() {
        self.deadlineButton.isUserInteractionEnabled = true;
        self.deadlineButton.addTarget(self, action: #selector(getPeriodInfo), for: .touchUpInside);
        self.deadlineTimeInterval = -1;
    }
    
    func deadlineTimerAction() {
        
        if (self.deadlineTimeInterval > 0 && self.deadlineTimeInterval != MAX_TIME_INTERVAL) {
            self.deadlineTimeInterval -= 1;
        }
        
        if (self.deadlineTimeInterval == 0) {
            self.betService.getPeriods(gameEn: self.gameEn);
        }
        
        let attText = LotteryUtil.getDeadlineContent(timeInterval: self.deadlineTimeInterval, subPeriod: self.betService.currentSubPeriod);
        self.deadlineButton.setAttributedTitle(attText, for: .normal);
        
        if (self.deadlineTimeInterval == 59 || self.deadlineTimeInterval == 1) {
            CommonUtil.vibrate();
        }
    }
    
}
