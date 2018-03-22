//
//  NoticeBallListView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class NoticeBallListView: UIView {
    var noticeBallViewArray = Array<LotteryBaseBallView>();

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        
        let ballWidth = BALL_WIDTH*0.95;
        for i in 0..<7 {
            let ballView = LotteryBaseBallView(frame: CGRect(x: ballWidth*1.1*CGFloat(i), y: 0, width: ballWidth, height: ballWidth), ballColor: .red);
            ballView.isUserInteractionEnabled = false;
            ballView.isSelected = true;
            ballView.tag = i;
            self.addSubview(ballView);
            self.noticeBallViewArray.append(ballView);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(ballString: String, isFirst: Bool) {
        let ballContent = ballString;
        var redBallIntArray = Array<Int>();
        var blueBallIntArray = Array<Int>();
        if (ballContent.contains(":")) {//大盘彩
            let dpcIntArrayList = LotteryUtil.toBallIntArrayDPCNormal(string: ballString);
            redBallIntArray = dpcIntArrayList[0];
            blueBallIntArray = dpcIntArrayList[1];
        } else {//D11
            redBallIntArray = LotteryUtil.toBallIntArrayD11Renxuan(string: ballString);
        }
        
        for i in 0..<redBallIntArray.count {
            let ballIntString = CommonUtil.toBallNumberString(i: redBallIntArray[i]);
            let ballView = self.noticeBallViewArray[i];
            ballView.setTitle(ballIntString, for: .normal);
            if (isFirst) {
                ballView.isSelected = true;
            } else {
                ballView.changeWhiteGround();
            }
            self.addSubview(ballView);
        }
        
        for i in 0..<blueBallIntArray.count {
            let ballIntString = CommonUtil.toBallNumberString(i: blueBallIntArray[i]);
            let ballView = self.noticeBallViewArray[redBallIntArray.count+i];
            ballView.ballColor = .blue;
            ballView.changeBlueColor();
            ballView.setTitle(ballIntString, for: .normal);
            if (isFirst) {
                ballView.isSelected = true;
            } else {
                ballView.changeWhiteGround();
            }
            self.addSubview(ballView);
        }
        
        for ballView in self.noticeBallViewArray {
            if (ballView.titleLabel?.text?.isEmpty == false) {
                ballView.isHidden = false;
            } else {
                ballView.isHidden = true;
            }
        }
        
    }
}
