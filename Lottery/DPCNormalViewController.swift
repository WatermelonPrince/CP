//
//  DPCNormalViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DPCNormalViewController: DPCBaseViewController {
    var shakeButton: UIButton!;
    var descriptionLabel: UILabel!;
    var redBallBoardView: DPCBallBoardView!;
    var blueBallBoardView: DPCBallBoardView!;
    
    var redRandomArray = Array<Int>();
    var blueRandomArray = Array<Int>();

    override func viewDidLoad() {
        super.viewDidLoad();
        self.setBoard();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if (self.isForEdit == true) {
            let content = self.editBallStringArray[0];
            let ballArrayList = LotteryUtil.toBallIntArrayDPCNormal(string: content);
            self.redBallBoardView.ballNumberArray = ballArrayList[0];
            self.blueBallBoardView.ballNumberArray = ballArrayList[1];
            self.redBallBoardView.updateBallSelection();
            self.blueBallBoardView.updateBallSelection();
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBoard() {
        //摇一摇机选
        let shakeButtonWidth = 120;
        let shakeButtonHeight = 120 * 96/324;
        self.shakeButton = UIButton(frame: CGRect(x: 0, y: 20, width: shakeButtonWidth, height: shakeButtonHeight));
        self.shakeButton.setImage(UIImage(named: "icon_board_shake"), for: .normal);
        self.scrollView.addSubview(self.shakeButton);
        self.shakeButton.addTarget(self, action: #selector(shakeAction), for: .touchUpInside);
        
        //DescriptionLabel
        self.descriptionLabel = UILabel(frame: CGRect(x: self.shakeButton.frame.maxX+5, y: self.shakeButton.frame.minY, width: self.view.frame.width-self.shakeButton.frame.width-5-10, height: self.shakeButton.frame.height));
        self.descriptionLabel.textColor = COLOR_FONT_TEXT;
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14);
        self.descriptionLabel.textAlignment = .right;
        self.scrollView.addSubview(self.descriptionLabel);
        self.descriptionLabel.text = "至少选择\(self.minRedBalls)个红球,\(self.minBlueBalls)个蓝球";
        
        //红球
        self.redBallBoardView = DPCBallBoardView(frame: CGRect(x: 0, y: self.shakeButton.frame.maxY+10, width: self.view.frame.width, height: CommonUtil.heightOfBallBoard(number: self.totalRedBalls)), ballColor: .red, number: self.totalRedBalls);
        self.scrollView.addSubview(self.redBallBoardView);
        
        //分割线
        let separatorLine = UIView(frame: CGRect(x: 0, y: self.redBallBoardView.frame.maxY+5, width: self.view.frame.width, height: DIMEN_BORDER));
        separatorLine.backgroundColor = COLOR_BORDER;
        self.scrollView.addSubview(separatorLine);
        
        //蓝球
        self.blueBallBoardView = DPCBallBoardView(frame: CGRect(x: 0, y: separatorLine.frame.maxY+5, width: self.view.frame.width, height: CommonUtil.heightOfBallBoard(number: self.totalBlueBalls)), ballColor: .blue, number: self.totalBlueBalls);
        self.scrollView.addSubview(self.blueBallBoardView);
        
        //Bounds
        self.scrollView.contentSize.height = self.blueBallBoardView.frame.maxY + self.bottomBarView.frame.height + self.scrollView.frame.minY + 20;
    }
    
    override func ballNumberChangeAction(_ notification: Notification) {
        if (self.isShown == false) {
            return;
        }
        
        let redBallNumber = self.redBallBoardView.ballNumberArray.count;
        let blueBallNumber = self.blueBallBoardView.ballNumberArray.count;
        
        //左侧按钮
        if (redBallNumber+blueBallNumber > 0) {
            self.bottomBarView.clearButton.isHidden = false;
        } else {
            self.bottomBarView.clearButton.isHidden = true;
        }
        self.bottomBarView.machineSelectionButton.isHidden = !self.bottomBarView.clearButton.isHidden;
        
        
        let totalNumber = LotteryUtil.totalNumberDPCNormal(redBallNumber: redBallNumber, blueBallNumber: blueBallNumber, minRedBalls: self.minRedBalls, minBlueBalls: self.minBlueBalls);
        
        self.bottomBarView.setData(totalNumber: totalNumber);
    }
    
    override func confirmAction() {
        super.confirmAction();
        //是否满足条件
        if (self.redBallBoardView.ballNumberArray.count < self.minRedBalls || self.blueBallBoardView.ballNumberArray.count < self.minBlueBalls) {
            
            if (self.redBallBoardView.ballNumberArray.count + self.blueBallBoardView.ballNumberArray.count == 0) {
                self.shakeAction();
            } else {
               ViewUtil.showToast(text: "至少选择\(self.minRedBalls)个红球，\(self.minBlueBalls)个蓝球");
            }
            
            return;
        }
        
        //Sort
        self.redBallBoardView.ballNumberArray.sort{$0 < $1};
        self.blueBallBoardView.ballNumberArray.sort{$0 < $1};
        
        //selectedBallString
        let selectedBallString = LotteryUtil.toBallStringDPCNormal(redBallArray: self.redBallBoardView.ballNumberArray, blueBallArray: self.blueBallBoardView.ballNumberArray)
        
        if (self.editBallStringArray.count > 0) {
            self.editBallStringArray = [selectedBallString];
        } else {
            self.newBallStringArray = [selectedBallString];
        }
        self.navAction();
    }
    
    override func shakeAction() {
        super.shakeAction();
        self.redRandomArray = CommonUtil.randomIntArray(total: self.totalRedBalls, count: self.minRedBalls);
        self.blueRandomArray = CommonUtil.randomIntArray(total: self.totalBlueBalls, count: self.minBlueBalls);
    }
    
    override func autoSelectAction() {
        if (self.shakeTimer != nil) {
            if (self.redRandomArray.count > 0) {
                let redInt = self.redRandomArray[0];
                let redBall = self.redBallBoardView.ballViewArray[redInt-1];
                ViewUtil.shakeAnimationForView(view: redBall);
                redBall.sendActions(for: .touchUpInside);
                self.redRandomArray.remove(at: 0);
            } else if (self.blueRandomArray.count > 0) {
                let blueInt = self.blueRandomArray[0];
                let blueBall = self.blueBallBoardView.ballViewArray[blueInt-1];
                ViewUtil.shakeAnimationForView(view: blueBall);
                blueBall.sendActions(for: .touchUpInside);
                self.blueRandomArray.remove(at: 0);
            } else {
                self.shakeTimer?.invalidate();
                self.shakeTimer = nil;
                self.view.isUserInteractionEnabled = true;
            }
        }
        
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        self.shakeVibrateAction();
    }

}
