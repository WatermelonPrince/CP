//
//  DLTDantuoViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/15.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DLTDantuoViewController: DPCDantuoViewController {

    var danRedBallBoardView: DPCBallBoardView!;
    var tuoRedBallBoardView: DPCBallBoardView!;
    var danBlueBallBoardView: DPCBallBoardView!;
    var tuoBlueBallBoardView: DPCBallBoardView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "大乐透胆拖";
        self.totalRedBalls = 35;
        self.totalBlueBalls = 12;
        self.minRedBalls = 5;
        self.minBlueBalls = 2;
        self.navController = DLTOrderViewController();
        self.navController.gameName = self.gameName;
        self.navController.gameId = self.gameId;
        self.navController.gameEn = self.gameEn;
        
        self.setBoard();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if (self.isForEdit == true) {
            let content = self.editBallStringArray[0];
            let ballArrayList = LotteryUtil.toBallIntArrayDLTDantuo(string: content);
            self.danRedBallBoardView.ballNumberArray = ballArrayList[0];
            self.tuoRedBallBoardView.ballNumberArray = ballArrayList[1];
            self.danBlueBallBoardView.ballNumberArray = ballArrayList[2];
            self.tuoBlueBallBoardView.ballNumberArray = ballArrayList[3];
            self.danRedBallBoardView.updateBallSelection();
            self.tuoRedBallBoardView.updateBallSelection();
            self.danBlueBallBoardView.updateBallSelection();
            self.tuoBlueBallBoardView.updateBallSelection();
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBoard() {
        //胆码前区
        let danRedBallLabel = DPCDantuoDescriptionLabel(frame: CGRect(x: self.dantuoIntroButton.frame.minX, y: self.dantuoIntroButton.frame.maxY+10, width: self.view.frame.width, height: self.dantuoIntroButton.frame.height));
        danRedBallLabel.text = "胆码-前区,最多选4个,最少选1个";
        self.scrollView.addSubview(danRedBallLabel);
        
        self.danRedBallBoardView = DPCBallBoardView(frame: CGRect(x: 0, y: danRedBallLabel.frame.maxY+10, width: self.view.frame.width, height: CommonUtil.heightOfBallBoard(number: self.totalRedBalls)), ballColor: .red, number: self.totalRedBalls);
        self.scrollView.addSubview(self.danRedBallBoardView);
        
        //拖码前区
        let tuoRedBallLabel = DPCDantuoDescriptionLabel(frame: CGRect(x: self.dantuoIntroButton.frame.minX, y: self.danRedBallBoardView.frame.maxY+10, width: self.view.frame.width, height: self.dantuoIntroButton.frame.height));
        tuoRedBallLabel.text = "拖码-前区";
        self.scrollView.addSubview(tuoRedBallLabel);
        
        self.tuoRedBallBoardView = DPCBallBoardView(frame: CGRect(x: 0, y: tuoRedBallLabel.frame.maxY+10, width: self.view.frame.width, height: CommonUtil.heightOfBallBoard(number: self.totalRedBalls)), ballColor: .red, number: self.totalRedBalls);
        self.scrollView.addSubview(self.tuoRedBallBoardView);
        
        //胆码后区
        let danBlueBallLabel = DPCDantuoDescriptionLabel(frame: CGRect(x: self.dantuoIntroButton.frame.minX, y: self.tuoRedBallBoardView.frame.maxY+10, width: self.view.frame.width, height: self.dantuoIntroButton.frame.height));
        danBlueBallLabel.text = "胆码-后区,最多选1个";
        self.scrollView.addSubview(danBlueBallLabel);
        
        self.danBlueBallBoardView = DPCBallBoardView(frame: CGRect(x: 0, y: danBlueBallLabel.frame.maxY+10, width: self.view.frame.width, height: CommonUtil.heightOfBallBoard(number: self.totalBlueBalls)), ballColor: .blue, number: self.totalBlueBalls);
        self.scrollView.addSubview(self.danBlueBallBoardView);
        
        //拖码后区
        let tuoBlueBallLabel = DPCDantuoDescriptionLabel(frame: CGRect(x: self.dantuoIntroButton.frame.minX, y: self.danBlueBallBoardView.frame.maxY+10, width: self.view.frame.width, height: self.dantuoIntroButton.frame.height));
        tuoBlueBallLabel.text = "拖码-后区,最少选择2个";
        self.scrollView.addSubview(tuoBlueBallLabel);
        
        self.tuoBlueBallBoardView = DPCBallBoardView(frame: CGRect(x: 0, y: tuoBlueBallLabel.frame.maxY+10, width: self.view.frame.width, height: CommonUtil.heightOfBallBoard(number: self.totalBlueBalls)), ballColor: .blue, number: self.totalBlueBalls);
        self.scrollView.addSubview(self.tuoBlueBallBoardView);
        
        //Bounds
        self.scrollView.contentSize.height = self.tuoBlueBallBoardView.frame.maxY + self.bottomBarView.frame.height + self.scrollView.frame.minY + 20;
    }
    
    override func ballNumberChangeAction(_ notification: Notification) {
        if (self.isShown == false) {
            return;
        }
        
        let danRedBallNumber = self.danRedBallBoardView.ballNumberArray.count;
        let tuoRedBallNumber = self.tuoRedBallBoardView.ballNumberArray.count;
        let danBlueBallNumber = self.danBlueBallBoardView.ballNumberArray.count;
        let tuoBlueBallNumber = self.tuoBlueBallBoardView.ballNumberArray.count;
        
        //左侧按钮
        if (danRedBallNumber+tuoRedBallNumber+danBlueBallNumber+tuoBlueBallNumber > 0) {
            self.bottomBarView.clearButton.isHidden = false;
        } else {
            self.bottomBarView.clearButton.isHidden = true;
        }
        self.bottomBarView.machineSelectionButton.isHidden = !self.bottomBarView.clearButton.isHidden;
        
        //胆码个数限制
        if (danRedBallNumber > 4) {
            ViewUtil.showToast(text: "最多只能选4个前区胆码");
            self.danRedBallBoardView.removeItem(num: self.danRedBallBoardView.ballNumberArray.last!);
            return;
        }
        
        if (danBlueBallNumber > 1) {
            ViewUtil.showToast(text: "最多只能选1个后区胆码");
            self.danBlueBallBoardView.removeItem(num: self.danBlueBallBoardView.ballNumberArray.last!);
            return;
        }
        
        //前区胆码拖码不相同
        let boardView = notification.object as! LotteryBaseBallBoardView;
        if (boardView == self.danRedBallBoardView) {
            for num in self.tuoRedBallBoardView.ballNumberArray.enumerated() {
                if (num.element == self.danRedBallBoardView.ballNumberArray.last) {
                    self.tuoRedBallBoardView.removeItem(num: num.element);
                }
            }
            
        } else if (boardView == self.tuoRedBallBoardView) {
            for num in self.danRedBallBoardView.ballNumberArray.enumerated() {
                if (num.element == self.tuoRedBallBoardView.ballNumberArray.last) {
                    self.danRedBallBoardView.removeItem(num: num.element);
                }
            }
        }
        
        //后区胆码拖码不相同
        if (boardView == self.danBlueBallBoardView) {
            for num in self.tuoBlueBallBoardView.ballNumberArray.enumerated() {
                if (num.element == self.danBlueBallBoardView.ballNumberArray.last) {
                    self.tuoBlueBallBoardView.removeItem(num: num.element);
                }
            }
            
        } else if (boardView == self.tuoBlueBallBoardView) {
            for num in self.danBlueBallBoardView.ballNumberArray.enumerated() {
                if (num.element == self.tuoBlueBallBoardView.ballNumberArray.last) {
                    self.danBlueBallBoardView.removeItem(num: num.element);
                }
            }
        }
        
        var totalNumber = LotteryUtil.totalNumberDLTDantuo(danRedBallNumber: danRedBallNumber, tuoRedBallNumber: tuoRedBallNumber, danBlueBallNumber: danBlueBallNumber, tuoBlueBallNumber: tuoBlueBallNumber);
        
        if (danRedBallNumber < 1 || danRedBallNumber + tuoRedBallNumber < self.minRedBalls || tuoBlueBallNumber < 2 || danBlueBallNumber + tuoBlueBallNumber < self.minBlueBalls) {
            totalNumber = 0;
        }
        self.bottomBarView.setData(totalNumber: totalNumber);
    }
    
    override func confirmAction() {
        super.confirmAction();
        //是否满足条件
        let danRedBallNumber = self.danRedBallBoardView.ballNumberArray.count;
        let tuoRedBallNumber = self.tuoRedBallBoardView.ballNumberArray.count;
        let danBlueBallNumber = self.danBlueBallBoardView.ballNumberArray.count;
        let tuoBlueBallNumber = self.tuoBlueBallBoardView.ballNumberArray.count;
        
        if (danRedBallNumber < 1 || danRedBallNumber + tuoRedBallNumber < self.minRedBalls || tuoBlueBallNumber < 2 || danBlueBallNumber + tuoBlueBallNumber < self.minBlueBalls) {
            ViewUtil.showToast(text: "请至少选择1注");
            return;
        }
        
        //Sort
        self.danRedBallBoardView.ballNumberArray.sort{$0 < $1};
        self.tuoRedBallBoardView.ballNumberArray.sort{$0 < $1};
        self.danBlueBallBoardView.ballNumberArray.sort{$0 < $1};
        self.tuoBlueBallBoardView.ballNumberArray.sort{$0 < $1};
        
        //selectedBallString
        let selectedBallString = LotteryUtil.toBallStringDLTDantuo(danRedBallArray: self.danRedBallBoardView.ballNumberArray, tuoRedBallArray: self.tuoRedBallBoardView.ballNumberArray, danBlueBallArray: self.danBlueBallBoardView.ballNumberArray, tuoBlueBallArray: self.tuoBlueBallBoardView.ballNumberArray);
        
        if (self.editBallStringArray.count > 0) {
            self.editBallStringArray = [selectedBallString];
        } else {
            self.newBallStringArray = [selectedBallString];
        }
        self.navAction();
    }
    
    override func dropDownButtonChangeAction() {
        LotteryUtil.saveLotterySelectedTypeInt(gameEn: self.gameEn, selectedInt: 1);
    }


}
