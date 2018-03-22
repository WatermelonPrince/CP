//
//  SSQDantuoViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/13.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class SSQDantuoViewController: DPCDantuoViewController {
    var danRedBallBoardView: DPCBallBoardView!;
    var tuoRedBallBoardView: DPCBallBoardView!;
    var blueBallBoardView: DPCBallBoardView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "双色球胆拖";
        self.totalRedBalls = 33;
        self.totalBlueBalls = 16;
        self.minRedBalls = 6;
        self.minBlueBalls = 1;
        self.navController = SSQOrderViewController();
        self.navController.gameName = self.gameName;
        self.navController.gameId = self.gameId;
        self.navController.gameEn = self.gameEn;
        
        self.setBoard();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if (self.isForEdit == true) {
            let content = self.editBallStringArray[0];
            let ballArrayList = LotteryUtil.toBallIntArraySSQDantuo(string: content);
            self.danRedBallBoardView.ballNumberArray = ballArrayList[0];
            self.tuoRedBallBoardView.ballNumberArray = ballArrayList[1];
            self.blueBallBoardView.ballNumberArray = ballArrayList[2];
            self.danRedBallBoardView.updateBallSelection();
            self.tuoRedBallBoardView.updateBallSelection();
            self.blueBallBoardView.updateBallSelection();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBoard() {
        //胆码区
        let danRedBallLabel = DPCDantuoDescriptionLabel(frame: CGRect(x: self.dantuoIntroButton.frame.minX, y: self.dantuoIntroButton.frame.maxY+10, width: self.view.frame.width, height: self.dantuoIntroButton.frame.height));
        danRedBallLabel.text = "胆码区,红球,至少选择1个,最多5个";
        self.scrollView.addSubview(danRedBallLabel);
        
        self.danRedBallBoardView = DPCBallBoardView(frame: CGRect(x: 0, y: danRedBallLabel.frame.maxY+10, width: self.view.frame.width, height: CommonUtil.heightOfBallBoard(number: self.totalRedBalls)), ballColor: .red, number: self.totalRedBalls);
        self.scrollView.addSubview(self.danRedBallBoardView);
        
        //拖码区
        let tuoRedBallLabel = DPCDantuoDescriptionLabel(frame: CGRect(x: self.dantuoIntroButton.frame.minX, y: self.danRedBallBoardView.frame.maxY+10, width: self.view.frame.width, height: self.dantuoIntroButton.frame.height));
        tuoRedBallLabel.text = "拖码区,红球,至少选择2个";
        self.scrollView.addSubview(tuoRedBallLabel);
        
        self.tuoRedBallBoardView = DPCBallBoardView(frame: CGRect(x: 0, y: tuoRedBallLabel.frame.maxY+10, width: self.view.frame.width, height: CommonUtil.heightOfBallBoard(number: self.totalRedBalls)), ballColor: .red, number: self.totalRedBalls);
        self.scrollView.addSubview(self.tuoRedBallBoardView);
        
        //蓝球区
        let blueBallLabel = DPCDantuoDescriptionLabel(frame: CGRect(x: self.dantuoIntroButton.frame.minX, y: self.tuoRedBallBoardView.frame.maxY+10, width: self.view.frame.width, height: self.dantuoIntroButton.frame.height));
        blueBallLabel.text = "请至少选择1个蓝球";
        self.scrollView.addSubview(blueBallLabel);
        
        self.blueBallBoardView = DPCBallBoardView(frame: CGRect(x: 0, y: blueBallLabel.frame.maxY+10, width: self.view.frame.width, height: CommonUtil.heightOfBallBoard(number: self.totalBlueBalls)), ballColor: .blue, number: self.totalBlueBalls);
        self.scrollView.addSubview(self.blueBallBoardView);
        
        //Bounds
        self.scrollView.contentSize.height = self.blueBallBoardView.frame.maxY + self.bottomBarView.frame.height + self.scrollView.frame.minY + 20;
    }
    
    override func ballNumberChangeAction(_ notification: Notification) {
        if (self.isShown == false) {
            return;
        }
        
        let danRedBallNumber = self.danRedBallBoardView.ballNumberArray.count;
        let tuoRedBallNumber = self.tuoRedBallBoardView.ballNumberArray.count;
        let blueBallNumber = self.blueBallBoardView.ballNumberArray.count;
        
        //左侧按钮
        if (danRedBallNumber+tuoRedBallNumber+blueBallNumber > 0) {
            self.bottomBarView.clearButton.isHidden = false;
        } else {
            self.bottomBarView.clearButton.isHidden = true;
        }
        self.bottomBarView.machineSelectionButton.isHidden = !self.bottomBarView.clearButton.isHidden;
        
        //胆码个数限制
        if (danRedBallNumber > 5) {
            ViewUtil.showToast(text: "最多只能选5个红球胆码");
            self.danRedBallBoardView.removeItem(num: self.danRedBallBoardView.ballNumberArray.last!);
            return;
        }
        
        //胆码拖码不相同
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
     
        var totalNumber = LotteryUtil.totalNumberSSQDantuo(danRedBallNumber: danRedBallNumber, tuoRedBallNumber: tuoRedBallNumber, blueBallNumber: blueBallNumber);
        
        if (danRedBallNumber < 1 || tuoRedBallNumber < 2 || danRedBallNumber + tuoRedBallNumber < 6 || blueBallNumber < 1) {
            totalNumber = 0;
        }
        self.bottomBarView.setData(totalNumber: totalNumber);
    }
    
    override func confirmAction() {
        super.confirmAction();
        //是否满足条件
        let danRedBallNumber = self.danRedBallBoardView.ballNumberArray.count;
        let tuoRedBallNumber = self.tuoRedBallBoardView.ballNumberArray.count;
        let blueBallNumber = self.blueBallBoardView.ballNumberArray.count;
        
        if (danRedBallNumber < 1 || tuoRedBallNumber < 2 || danRedBallNumber + tuoRedBallNumber < self.minRedBalls || blueBallNumber < self.minBlueBalls) {
            ViewUtil.showToast(text: "请至少选择1注");
            return;
        }
        
        //Sort
        self.danRedBallBoardView.ballNumberArray.sort{$0 < $1};
        self.tuoRedBallBoardView.ballNumberArray.sort{$0 < $1};
        self.blueBallBoardView.ballNumberArray.sort{$0 < $1};
        
        //selectedBallString
        let selectedBallString = LotteryUtil.toBallStringSSQDantuo(danRedBallArray: self.danRedBallBoardView.ballNumberArray, tuoRedBallArray: self.tuoRedBallBoardView.ballNumberArray, blueBallArray: self.blueBallBoardView.ballNumberArray);
        
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
