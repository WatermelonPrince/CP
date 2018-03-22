//
//  D11NormalQian1ViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11NormalQian1ViewController: D11NormalViewController {
    var ballBoardView: D11NormalBallBoardView!;
    var randomArray = Array<Int>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.prizeContent == "0") {
            self.prizeContent = "13";
        } else {
            self.setDescriptionLabel();
        }
        
        //BoardView
        self.ballBoardView = D11NormalBallBoardView(frame: CGRect(x: 0, y: self.descriptionLabel.frame.maxY+5, width: self.view.frame.width, height: BALL_WIDTH*2.8 + 20));
        self.ballBoardView.selectPointLabel.text = "万位";
        self.ballBoardView.selectAllButton.isHidden = true;
        self.scrollView.addSubview(self.ballBoardView);
        
        //Bounds
        self.scrollView.contentSize.height = self.ballBoardView.frame.maxY + self.bottomBarView.frame.height + self.scrollView.frame.minY + 20;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        if (self.isForEdit == true) {
            let content = self.editBallStringArray[0];
            let ballArray = LotteryUtil.toBallIntArrayD11Renxuan(string: content);
            self.ballBoardView.ballNumberArray = ballArray;
            self.ballBoardView.updateBallSelection();
        }
        
    }
    
    override func ballNumberChangeAction(_ notification: Notification) {
        if (self.isShown == false) {
            return;
        }
        let ballNumber = self.ballBoardView.ballNumberArray.count;
        
        //左侧按钮
        if (ballNumber > 0) {
            self.bottomBarView.clearButton.isHidden = false;
        } else {
            self.bottomBarView.clearButton.isHidden = true;
        }
        self.bottomBarView.machineSelectionButton.isHidden = !self.bottomBarView.clearButton.isHidden;
        
        
        let totalNumber = LotteryUtil.totalNumberD11Qian1(ballNumber: ballNumber);
        self.bottomBarView.setData(totalNumber: totalNumber);
    }
    
    override func confirmAction() {
        super.confirmAction();
        //是否满足条件
        if (self.ballBoardView.ballNumberArray.count == 0) {
            self.shakeAction();
            return;
        }
        
        //Sort
        self.ballBoardView.ballNumberArray.sort{$0 < $1};
        
        //selectedBallString
        let selectedBallString = LotteryUtil.toBallStringD11Qian1(ballArray: self.ballBoardView.ballNumberArray);
        
        if (self.editBallStringArray.count > 0) {
            self.editBallStringArray[0] = selectedBallString;
        } else {
            self.newBallStringArray = [selectedBallString];
        }
        self.navAction();
    }
    
    override func shakeAction() {
        super.shakeAction();
        self.randomArray = CommonUtil.randomIntArray(total: 11, count: 1);
    }
    
    override func autoSelectAction() {
        if (self.shakeTimer != nil) {
            if (self.randomArray.count > 0) {
                let int = self.randomArray[0];
                let ball = self.ballBoardView.ballViewArray[int-1];
                ViewUtil.shakeAnimationForView(view: ball);
                ball.sendActions(for: .touchUpInside);
                self.randomArray.remove(at: 0);
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
            self.newBallStringArray.append(LotteryUtil.randomStringD11Qian1());
        }
        self.navAction();
    }
    
    override func dropDownButtonChangeAction() {
        (self.navController as! D11OrderViewController).d11Type = .qian1;
        LotteryUtil.saveLotterySelectedTypeInt(gameEn: self.gameEn, selectedInt: 7);
    }
    
    override func setDescriptionLabel() {
        if (self.descriptionLabel == nil) {
            return;
        }
        
        let subDescriptionString = "至少选1个号,猜对第1个开奖号即中";
        let descriptionAttString = LotteryUtil.toDescriptionAttString(subString: subDescriptionString, prizeContent: self.prizeContent);
        self.descriptionLabel.attributedText = descriptionAttString;
    }

}
