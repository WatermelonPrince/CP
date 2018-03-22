//
//  D11NormalQian2ZhixuanViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/27.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11NormalQian2ZhixuanViewController: D11NormalViewController {
    var wanBallBoardView: D11NormalBallBoardView!;
    var qianBallBoardView: D11NormalBallBoardView!;
    
    var randomWanArray = Array<Int>();
    var randomQianArray = Array<Int>();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.prizeContent == "0") {
            self.prizeContent = "130";
        } else {
            self.setDescriptionLabel();
        }
        
        //BoardView
        self.wanBallBoardView = D11NormalBallBoardView(frame: CGRect(x: 0, y: self.descriptionLabel.frame.maxY+5, width: self.view.frame.width, height: BALL_WIDTH*2.8 + 20));
        self.wanBallBoardView.selectPointLabel.text = "万位";
        self.wanBallBoardView.selectAllButton.isHidden = true;
        self.scrollView.addSubview(self.wanBallBoardView);
        
        let separatorLine = UIView(frame: CGRect(x: 0, y: self.wanBallBoardView.frame.maxY+5, width: self.view.frame.width, height: DIMEN_BORDER));
        separatorLine.backgroundColor = COLOR_BORDER;
        self.scrollView.addSubview(separatorLine);
        
        self.qianBallBoardView = D11NormalBallBoardView(frame: CGRect(x: 0, y: separatorLine.frame.maxY+5, width: self.view.frame.width, height: BALL_WIDTH*2.8 + 20));
        self.qianBallBoardView.selectPointLabel.text = "千位";
        self.qianBallBoardView.selectAllButton.isHidden = true;
        self.scrollView.addSubview(self.qianBallBoardView);
        
        //Bounds
        self.scrollView.contentSize.height = self.qianBallBoardView.frame.maxY + self.bottomBarView.frame.height + self.scrollView.frame.minY + 20;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        if (self.isForEdit == true) {
            let content = self.editBallStringArray[0];
            let ballArrayList = LotteryUtil.toBallIntArrayD11Qian2Zhixuan(string: content);
            self.wanBallBoardView.ballNumberArray = ballArrayList[0];
            self.qianBallBoardView.ballNumberArray = ballArrayList[1];
            self.wanBallBoardView.updateBallSelection();
            self.qianBallBoardView.updateBallSelection();
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func ballNumberChangeAction(_ notification: Notification) {
        if (self.isShown == false) {
            return;
        }
        
        let wanBallNumber = self.wanBallBoardView.ballNumberArray.count;
        let qianBallNumber = self.qianBallBoardView.ballNumberArray.count;
        
        //左侧按钮
        if (wanBallNumber+qianBallNumber > 0) {
            self.bottomBarView.clearButton.isHidden = false;
        } else {
            self.bottomBarView.clearButton.isHidden = true;
        }
        self.bottomBarView.machineSelectionButton.isHidden = !self.bottomBarView.clearButton.isHidden;
        
        //是否满足条件
        let mutualBallNumber = LotteryUtil.mutualNumberD11Qian2Zhixuan(wanBallArray: self.wanBallBoardView.ballNumberArray, qianBallArray: self.qianBallBoardView.ballNumberArray);
        
        let totalNumber = LotteryUtil.totalNumberD11Qian2Zhixuan(wanBallNumber: wanBallNumber, qianBallNumber: qianBallNumber, mutualBallNumber: mutualBallNumber);
        
        self.bottomBarView.setData(totalNumber: totalNumber);
    }
    
    override func confirmAction() {
        super.confirmAction();
        let wanBallNumber = self.wanBallBoardView.ballNumberArray.count;
        let qianBallNumber = self.qianBallBoardView.ballNumberArray.count;
        if (wanBallNumber + qianBallNumber == 0) {
            self.shakeAction();
            return;
        }
        
        //是否满足条件
        let mutualBallNumber = LotteryUtil.mutualNumberD11Qian2Zhixuan(wanBallArray: self.wanBallBoardView.ballNumberArray, qianBallArray: self.qianBallBoardView.ballNumberArray);
        
        let totalNumber = LotteryUtil.totalNumberD11Qian2Zhixuan(wanBallNumber: wanBallNumber, qianBallNumber: qianBallNumber, mutualBallNumber: mutualBallNumber);
        if (totalNumber == 0) {
            ViewUtil.showToast(text: "每位至少选1个不同号码");
            return;
        }
        
        //Sort
        self.wanBallBoardView.ballNumberArray.sort{$0 < $1};
        self.qianBallBoardView.ballNumberArray.sort{$0 < $1};
        
        
        //selectedBallString
        let selectedBallStringArray = LotteryUtil.toBallStringD11Qian2Zhixuan(wanBallNumberArray: self.wanBallBoardView.ballNumberArray, qianBallNumberArray: self.qianBallBoardView.ballNumberArray);
        
        if (self.editBallStringArray.count > 0) {
            self.editBallStringArray = selectedBallStringArray;
        } else {
            self.newBallStringArray = selectedBallStringArray;
        }
        self.navAction();
    }
    
    override func shakeAction() {
        super.shakeAction();
        self.randomWanArray = CommonUtil.randomIntArray(total: 11, count: 1);
        self.randomQianArray = CommonUtil.randomIntArray(total: 11, count: 1);
        while (self.randomWanArray[0] == self.randomQianArray[0]) {
            self.randomQianArray = CommonUtil.randomIntArray(total: 11, count: 1);
        }
        
    }
    
    override func autoSelectAction() {
        if (self.shakeTimer != nil) {
            if (self.randomWanArray.count > 0) {
                let int = self.randomWanArray[0];
                let wanBall = self.wanBallBoardView.ballViewArray[int-1];
                ViewUtil.shakeAnimationForView(view: wanBall);
                wanBall.sendActions(for: .touchUpInside);
                self.randomWanArray.remove(at: 0);
            } else if (self.randomQianArray.count > 0) {
                let int = self.randomQianArray[0];
                let qianBall = self.qianBallBoardView.ballViewArray[int-1];
                ViewUtil.shakeAnimationForView(view: qianBall);
                qianBall.sendActions(for: .touchUpInside);
                self.randomQianArray.remove(at: 0);
            } else {
                self.shakeTimer?.invalidate();
                self.shakeTimer = nil;
                self.view.isUserInteractionEnabled = true;
            }
        }
    }
    
    override func machineSelectionBasicAction(count: Int) {
        super.machineSelectionBasicAction(count: count);
        for _ in 0..<count {
            self.newBallStringArray.append(LotteryUtil.randomStringD11Qian2Zhixuan());
        }
        self.navAction();
    }
    
    override func dropDownButtonChangeAction() {
        (self.navController as! D11OrderViewController).d11Type = .qian2Zhixuan;
        LotteryUtil.saveLotterySelectedTypeInt(gameEn: self.gameEn, selectedInt: 8);
    }
    
    override func setDescriptionLabel() {
        if (self.descriptionLabel == nil) {
            return;
        }
        
        let subDescriptionString = "每位至少选1个号,按位猜对开奖前2位中";
        let descriptionAttString = LotteryUtil.toDescriptionAttString(subString: subDescriptionString, prizeContent: self.prizeContent);
        self.descriptionLabel.attributedText = descriptionAttString;

    }

}
