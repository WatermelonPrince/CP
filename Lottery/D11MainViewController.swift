//
//  D11MainViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit



let MAX_TIME_INTERVAL: TimeInterval = 1000000;

class D11MainViewController: LotteryMainBaseViewController {
    
    var deadlineTimer: Timer?;
    var deadlineTimeInterval: TimeInterval = MAX_TIME_INTERVAL;
    
    override func viewDidLoad() {
        
        //任选
        for i in 2..<9 {
            //Controller
            let renxuanViewController = D11NormalRenxuanViewController();
            renxuanViewController.minBalls = i;
            self.childVCs.append(renxuanViewController);
            //gameName
            let gameName = "任选\(CommonUtil.toChineseNumber(number: i))"
            self.gameNameArray.append(gameName);
            //TitleName
            let titleName = "任选\(CommonUtil.toChineseNumber(number: i))"
            self.titleNameArray.append(titleName);
        }
        
        //直一
        self.childVCs.append(D11NormalQian1ViewController());
        self.gameNameArray.append("前一");
        self.titleNameArray.append("前一");
        
        //前二直选
        self.childVCs.append(D11NormalQian2ZhixuanViewController());
        self.gameNameArray.append("前二直选");
        self.titleNameArray.append("前二直选");
        
        //前二组选
        let qian2ZuxuanViewController = D11NormalZuxuanViewController();
        qian2ZuxuanViewController.minBalls = 2;
        self.childVCs.append(qian2ZuxuanViewController);
        self.gameNameArray.append("前二组选");
        self.titleNameArray.append("前二组选");
        
        //前三直选
        self.childVCs.append(D11NormalQian3ZhixuanViewController());
        self.gameNameArray.append("前三直选");
        self.titleNameArray.append("前三直选");
        
        //前三组选
        let qian3ZuxuanViewController = D11NormalZuxuanViewController();
        qian3ZuxuanViewController.minBalls = 3;
        self.childVCs.append(qian3ZuxuanViewController);
        self.gameNameArray.append("前三组选");
        self.titleNameArray.append("前三组选");
        
        //任选胆拖
        for i in 2..<9 {
            //Controller
            let renxuanDantuoViewController = D11DantuoRenxuanViewController();
            renxuanDantuoViewController.minBalls = i;
            self.childVCs.append(renxuanDantuoViewController);
            //gameName
            let gameName = "任选\(CommonUtil.toChineseNumber(number: i))"
            self.gameNameArray.append(gameName);
            //TitleName
            let titleName = "任选\(CommonUtil.toChineseNumber(number: i))胆拖"
            self.titleNameArray.append(titleName);
        }
        //前二组选胆拖
        let qian2ZuxuanDantuoViewController = D11DantuoZuxuanViewController();
        qian2ZuxuanDantuoViewController.minBalls = 2;
        self.childVCs.append(qian2ZuxuanDantuoViewController);
        self.gameNameArray.append("前二组选");
        self.titleNameArray.append("前二组选胆拖");
        //前三组选胆拖
        let qian3ZuxuanDantuoViewController = D11DantuoZuxuanViewController();
        qian3ZuxuanDantuoViewController.minBalls = 3;
        self.childVCs.append(qian3ZuxuanDantuoViewController);
        self.gameNameArray.append("前三组选");
        self.titleNameArray.append("前三组选胆拖");
        
        //gameEn
        for vc in self.childVCs {
            vc.gameEn = self.gameEn;
        }

        //DropDownView
        self.dropDownView = D11MainDropDownView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height), gameNameArray: self.gameNameArray);
        self.view.addSubview(self.dropDownView);
        
        if (self.editBallStringArray.count == 0) {
            //默认如果没存储 返回0 让childVC的select 0,也就是第一个选项
            let selectedInt = LotteryUtil.lotterySelectedTypeInt(gameEn: self.gameEn);
            if (selectedInt != nil) {
                self.selectedInt = selectedInt!;
            }else{
                switch self.rule {
                case "REN_2":
                    self.selectedInt = 0;
                case "REN_3":
                    self.selectedInt = 1;
                case "REN_4":
                    self.selectedInt = 2;
                case "REN_5":
                    self.selectedInt = 3;
                case "REN_6":
                    self.selectedInt = 4;
                case "REN_7":
                    self.selectedInt = 5;
                case "REN_8":
                    self.selectedInt = 6;
                case "QIAN_1":
                    self.selectedInt = 7;
                case "QIAN_2_ZHIXUAN":
                    self.selectedInt = 8;
                case "QIAN_2_ZUXUAN":
                    self.selectedInt = 9;
                case "QIAN_3_ZHIXUAN":
                    self.selectedInt = 10;
                case "QIAN_3_ZUXUAN":
                    self.selectedInt = 11;
                default:
                    self.selectedInt = 7;

                }
            }

        }
        
        super.viewDidLoad();
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
        let vc = self.currentViewController as? D11BaseViewController;
        if (vc != nil) {
            vc?.deadlineButton.isUserInteractionEnabled = false;
        }
        let currentSubPeriod = self.betService.currentSubPeriod;
        if (currentSubPeriod != nil && self.periodId != self.betService.currentPeriod.periodId) {
            ViewUtil.showToast(text: "期次已切换，当前是第\(currentSubPeriod!)期");
        }
    }
    
    func onCompleteFail() {
        let vc = self.currentViewController as? D11BaseViewController;
        if (vc != nil) {
            vc?.deadlineButton.isUserInteractionEnabled = true;
            vc?.deadlineButton.addTarget(self, action: #selector(getPeriodInfo), for: .touchUpInside);
            self.deadlineTimeInterval = -1;
        }
    }
    
    func deadlineTimerAction() {
        if (self.currentViewController == nil) {
            return;
        }
        
        let vc = self.currentViewController as! D11BaseViewController;
        
        if (self.deadlineTimeInterval > 0 && self.deadlineTimeInterval != MAX_TIME_INTERVAL) {
            self.deadlineTimeInterval -= 1;
        }
        
        if (self.deadlineTimeInterval == 0) {
            self.betService.getPeriods(gameEn: self.gameEn);
        }
        
        let attText = LotteryUtil.getDeadlineContent(timeInterval: self.deadlineTimeInterval, subPeriod: self.betService.currentSubPeriod);
        vc.deadlineButton.setAttributedTitle(attText, for: .normal);
        
        if (self.deadlineTimeInterval == 59 || self.deadlineTimeInterval == 1) {
            CommonUtil.vibrate();
        }
        
    }
}
