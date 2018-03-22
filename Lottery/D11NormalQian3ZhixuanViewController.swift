//
//  D11NormalQian3ZhixuanViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/29.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11NormalQian3ZhixuanViewController: D11NormalViewController {
    var wanBallBoardView: D11NormalBallBoardView!;
    var qianBallBoardView: D11NormalBallBoardView!;
    var baiBallBoardView: D11NormalBallBoardView!;
    
    var randomWanArray = Array<Int>();
    var randomQianArray = Array<Int>();
    var randomBaiArray = Array<Int>();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        if (self.prizeContent == "0") {
            self.prizeContent = "1170";
        } else {
            self.setDescriptionLabel();
        }
        
        //BoardView
        self.wanBallBoardView = D11NormalBallBoardView(frame: CGRect(x: 0, y: self.descriptionLabel.frame.maxY+5, width: self.view.frame.width, height: BALL_WIDTH*2.8 + 20));
        self.wanBallBoardView.selectPointLabel.text = "万位";
        self.wanBallBoardView.selectAllButton.isHidden = true;
        self.scrollView.addSubview(self.wanBallBoardView);
        
        let separatorLine1 = UIView(frame: CGRect(x: 0, y: self.wanBallBoardView.frame.maxY+5, width: self.view.frame.width, height: DIMEN_BORDER));
        separatorLine1.backgroundColor = COLOR_BORDER;
        self.scrollView.addSubview(separatorLine1);
        
        self.qianBallBoardView = D11NormalBallBoardView(frame: CGRect(x: 0, y: separatorLine1.frame.maxY+5, width: self.view.frame.width, height: BALL_WIDTH*2.8 + 20));
        self.qianBallBoardView.selectPointLabel.text = "千位";
        self.qianBallBoardView.selectAllButton.isHidden = true;
        self.scrollView.addSubview(self.qianBallBoardView);
        
        let separatorLine2 = UIView(frame: CGRect(x: 0, y: self.qianBallBoardView.frame.maxY+5, width: self.view.frame.width, height: DIMEN_BORDER));
        separatorLine2.backgroundColor = COLOR_BORDER;
        self.scrollView.addSubview(separatorLine2);
        
        self.baiBallBoardView = D11NormalBallBoardView(frame: CGRect(x: 0, y: separatorLine2.frame.maxY+5, width: self.view.frame.width, height: BALL_WIDTH*2.8 + 20));
        self.baiBallBoardView.selectPointLabel.text = "百位";
        self.baiBallBoardView.selectAllButton.isHidden = true;
        self.scrollView.addSubview(self.baiBallBoardView);
        
        //Bounds
        self.scrollView.contentSize.height = self.baiBallBoardView.frame.maxY + self.bottomBarView.frame.height + self.scrollView.frame.minY + 20;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        if (self.isForEdit == true) {
            let content = self.editBallStringArray[0];
            let ballArrayList = LotteryUtil.toBallIntArrayD11Qian3Zhixuan(string: content);
            self.wanBallBoardView.ballNumberArray = ballArrayList[0];
            self.qianBallBoardView.ballNumberArray = ballArrayList[1];
            self.baiBallBoardView.ballNumberArray = ballArrayList[2];
            self.wanBallBoardView.updateBallSelection();
            self.qianBallBoardView.updateBallSelection();
            self.baiBallBoardView.updateBallSelection();
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
        let baiBallNumber = self.baiBallBoardView.ballNumberArray.count;
        
        //左侧按钮
        if (wanBallNumber+qianBallNumber+baiBallNumber > 0) {
            self.bottomBarView.clearButton.isHidden = false;
        } else {
            self.bottomBarView.clearButton.isHidden = true;
        }
        self.bottomBarView.machineSelectionButton.isHidden = !self.bottomBarView.clearButton.isHidden;
        
        let mutualBallNumber = LotteryUtil.mutualNumberD11Qian3Zhixuan(wanBallArray: self.wanBallBoardView.ballNumberArray, qianBallArray: self.qianBallBoardView.ballNumberArray, baiBallArray: self.baiBallBoardView.ballNumberArray)
        
        let totalNumber = LotteryUtil.totalNumberD11Qian3Zhixuan(wanBallNumber: wanBallNumber, qianBallNumber: qianBallNumber,baiBallNumber: baiBallNumber, mutualBallNumber: mutualBallNumber);
        
        self.bottomBarView.setData(totalNumber: totalNumber);
    }
    
    override func confirmAction() {
        super.confirmAction();
        let wanBallNumber = self.wanBallBoardView.ballNumberArray.count;
        let qianBallNumber = self.qianBallBoardView.ballNumberArray.count;
        let baiBallNumber = self.qianBallBoardView.ballNumberArray.count;
        if (wanBallNumber + qianBallNumber + baiBallNumber == 0) {
            self.shakeAction();
            return;
        }
        
        //是否满足条件
        let mutualBallNumber = LotteryUtil.mutualNumberD11Qian3Zhixuan(wanBallArray: self.wanBallBoardView.ballNumberArray, qianBallArray: self.qianBallBoardView.ballNumberArray, baiBallArray: self.baiBallBoardView.ballNumberArray)
        
        let totalNumber = LotteryUtil.totalNumberD11Qian3Zhixuan(wanBallNumber: wanBallNumber, qianBallNumber: qianBallNumber, baiBallNumber: baiBallNumber,mutualBallNumber: mutualBallNumber);
        if (totalNumber == 0) {
            ViewUtil.showToast(text: "每位至少选1个不同号码");
            return;
        }
        
        //Sort
        self.wanBallBoardView.ballNumberArray.sort{$0 < $1};
        self.qianBallBoardView.ballNumberArray.sort{$0 < $1};
        self.baiBallBoardView.ballNumberArray.sort{$0 < $1};
        
        
        //selectedBallString
        let selectedBallStringArray = LotteryUtil.toBallStringD11Qian3Zhixuan(wanBallNumberArray: self.wanBallBoardView.ballNumberArray, qianBallNumberArray: self.qianBallBoardView.ballNumberArray, baiBallNumberArray: self.baiBallBoardView.ballNumberArray);
        
        if (self.editBallStringArray.count > 0) {
            self.editBallStringArray = selectedBallStringArray;
        } else {
            self.newBallStringArray = selectedBallStringArray;
        }
        self.navAction();
    }
    
    override func shakeAction() {
        super.shakeAction();
        let randomIntArrayList = LotteryUtil.randomIntArrayListD11Qian3Zhixuan();
        self.randomWanArray = randomIntArrayList[0];
        self.randomQianArray = randomIntArrayList[1];
        self.randomBaiArray = randomIntArrayList[2];
        
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
            } else if (self.randomBaiArray.count > 0) {
                let int = self.randomBaiArray[0];
                let baiBall = self.baiBallBoardView.ballViewArray[int-1];
                ViewUtil.shakeAnimationForView(view: baiBall);
                baiBall.sendActions(for: .touchUpInside);
                self.randomBaiArray.remove(at: 0);
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
            self.newBallStringArray.append(LotteryUtil.randomStringD11Qian3Zhixuan());
        }
        self.navAction();
    }
    
    override func dropDownButtonChangeAction() {
        (self.navController as! D11OrderViewController).d11Type = .qian3Zhixuan;
        LotteryUtil.saveLotterySelectedTypeInt(gameEn: self.gameEn, selectedInt: 10);
    }
    
    override func setDescriptionLabel() {
        if (self.descriptionLabel == nil) {
            return;
        }
        
        let subDescriptionString = "每位至少选1个号,按位猜对开奖前3位中";
        let descriptionAttString = LotteryUtil.toDescriptionAttString(subString: subDescriptionString, prizeContent: self.prizeContent);
        self.descriptionLabel.attributedText = descriptionAttString;
    }


}
