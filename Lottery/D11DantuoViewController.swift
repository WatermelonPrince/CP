//
//  D11DantuoViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/29.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11DantuoViewController: D11BaseViewController {
    var dantuoIntroButton: DantuoIntroButton!;
    var danBallBoardView: D11DantuoBallBoardView!;
    var tuoBallBoardView: D11DantuoBallBoardView!;
    var minBalls = 0;
    var isRenxuan = true;

    override func viewDidLoad() {
        super.viewDidLoad()

        //DantuoIntro
        self.dantuoIntroButton = DantuoIntroButton(frame: CGRect(x: 10, y: 10, width: 15*7, height: 16));
        self.scrollView.addSubview(self.dantuoIntroButton);
        
        //DescriptionLabel
        self.descriptionLabel = D11BaseDescriptionLabel(frame: CGRect(x: self.dantuoIntroButton.frame.minX, y: self.dantuoIntroButton.frame.maxY, width: self.view.frame.width-20*2, height: 30));
        self.scrollView.addSubview(self.descriptionLabel);
        
        //胆码
        self.danBallBoardView = D11DantuoBallBoardView(frame: CGRect(x: 0, y: self.descriptionLabel.frame.maxY + 5, width: self.view.frame.width, height: BALL_WIDTH*3.8 + 20));
        self.danBallBoardView.selectPointLabel.text = "胆码";
        self.danBallBoardView.leftLabel.text = "我认为必出的号码";
        self.danBallBoardView.rightLabel.text = "至少选1个,最多\(self.minBalls-1)个";
        self.danBallBoardView.selectAllButton.isHidden = true;
        self.scrollView.addSubview(self.danBallBoardView);
        
        //拖码
        self.tuoBallBoardView = D11DantuoBallBoardView(frame: CGRect(x: 0, y: self.danBallBoardView.frame.maxY + 5, width: self.view.frame.width, height: BALL_WIDTH*3.8 + 20));
        self.tuoBallBoardView.selectPointLabel.text = "拖码";
        self.tuoBallBoardView.leftLabel.text = "我认为可能出的号码";
        self.scrollView.addSubview(self.tuoBallBoardView);
        self.tuoBallBoardView.selectAllButton.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside);
        
        //Bounds
        self.scrollView.contentSize.height = self.tuoBallBoardView.frame.maxY + self.bottomBarView.frame.height + self.scrollView.frame.minY + 20;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if (self.isForEdit == true) {
            let content = self.editBallStringArray[0];
            let ballArrayList = LotteryUtil.toBallIntArrayD11Dantuo(string: content);
            self.danBallBoardView.ballNumberArray = ballArrayList[0];
            self.tuoBallBoardView.ballNumberArray = ballArrayList[1];
            self.danBallBoardView.updateBallSelection();
            self.tuoBallBoardView.updateBallSelection();
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
        
        let danBallNumber = self.danBallBoardView.ballNumberArray.count;
        let tuoBallNumber = self.tuoBallBoardView.ballNumberArray.count;
        
        //左侧按钮
        if (danBallNumber+tuoBallNumber > 0) {
            self.bottomBarView.clearButton.isHidden = false;
        } else {
            self.bottomBarView.clearButton.isHidden = true;
        }
        self.bottomBarView.machineSelectionButton.isHidden = !self.bottomBarView.clearButton.isHidden;
        
        var prefixText = "";
        if (self.isRenxuan) {
            prefixText = "任选\(CommonUtil.toChineseNumber(number: self.minBalls))"
        } else {
            prefixText = "前\(CommonUtil.toChineseNumber(number: self.minBalls))组选"
        }
        
        //胆码个数限制
        if (danBallNumber > self.minBalls-1) {
            ViewUtil.showToast(text: prefixText + "最多只能选\(self.minBalls-1)个胆码");
            self.danBallBoardView.removeItem(num: self.danBallBoardView.ballNumberArray.last!);
            return;
        }
        
        //拖码个数限制
        if (tuoBallNumber > 10) {
            ViewUtil.showToast(text: prefixText + "最多只能选10个拖码");
            self.tuoBallBoardView.removeItem(num: self.tuoBallBoardView.ballNumberArray.last!);
            return;
        }
        
        //胆码拖码不相同
        let boardView = notification.object as! LotteryBaseBallBoardView
        if (boardView == self.danBallBoardView) {
            for num in self.tuoBallBoardView.ballNumberArray.enumerated() {
                if (num.element == self.danBallBoardView.ballNumberArray.last) {
                    self.tuoBallBoardView.removeItem(num: num.element);
                }
            }
            
        } else if (boardView == self.tuoBallBoardView) {
            for num in self.danBallBoardView.ballNumberArray.enumerated() {
                if (num.element == self.tuoBallBoardView.ballNumberArray.last) {
                    self.danBallBoardView.removeItem(num: num.element);
                }
            }
        }
        
        let totalNumber = LotteryUtil.totalNumberD11Dantuo(danBallNumber: danBallNumber, tuoBallNumber: tuoBallNumber, minBalls: self.minBalls);
        self.bottomBarView.setData(totalNumber: totalNumber);
        
    }
    
    override func confirmAction() {
        super.confirmAction();
        //是否满足条件
        let danBallNumber = self.danBallBoardView.ballNumberArray.count;
        let tuoBallNumber = self.tuoBallBoardView.ballNumberArray.count;
        let totalNumber = LotteryUtil.totalNumberD11Dantuo(danBallNumber: danBallNumber, tuoBallNumber: tuoBallNumber, minBalls: self.minBalls);
        
        if (danBallNumber == 0) {
            ViewUtil.showToast(text: "请至少选1个胆码");
            return;
        }
        
        var prefixText = "";
        if (self.isRenxuan) {
            prefixText = "任选\(CommonUtil.toChineseNumber(number: self.minBalls))"
        } else {
            prefixText = "前\(CommonUtil.toChineseNumber(number: self.minBalls))组选"
        }
        
        if (totalNumber == 0) {
            ViewUtil.showToast(text: prefixText + "胆码加拖码至少要选\(self.minBalls)个");
            return;
        }
        
        //Sort
        self.danBallBoardView.ballNumberArray.sort{$0 < $1};
        self.tuoBallBoardView.ballNumberArray.sort{$0 < $1};
        
        //selectedBallString
        var selectedBallString = "";
        if (self.isRenxuan) {
            selectedBallString = LotteryUtil.toBallStringD11RenxuanDantuo(danBallArray: self.danBallBoardView.ballNumberArray, tuoBallArray: self.tuoBallBoardView.ballNumberArray, minBalls: self.minBalls);
        } else {
            selectedBallString = LotteryUtil.toBallStringD11ZuxuanDantuo(danBallArray: self.danBallBoardView.ballNumberArray, tuoBallArray: self.tuoBallBoardView.ballNumberArray, minBalls: self.minBalls);
        }
        
        if (self.editBallStringArray.count > 0) {
            self.editBallStringArray[0] = selectedBallString;
        } else {
            self.newBallStringArray = [selectedBallString];
        }
        self.navAction();
    }
    
    func selectAllAction() {
        if (self.danBallBoardView.ballNumberArray.count == 0) {
            ViewUtil.showToast(text: "请先选择胆码");
            return;
        }
        
        for i in 0..<11 {
            if (self.danBallBoardView.ballNumberArray.contains(i+1) == false && self.tuoBallBoardView.ballNumberArray.contains(i+1) == false) {
                self.tuoBallBoardView.ballNumberArray.append(i+1);
            }
        }
        self.tuoBallBoardView.updateBallSelection();
    }

}
