//
//  D11NormalBallBoardView.swift
//  Lottery
//
//  Created by DTY on 17/2/22.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11NormalBallBoardView: D11BaseBallBoardView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //选号/位数
        self.selectPointLabel = LotteryTrianglePointView(frame: CGRect(x: BALL_WIDTH*0.3, y: BALL_WIDTH*0.25, width: BALL_WIDTH*0.9, height: BALL_WIDTH*0.4));
        self.addSubview(self.selectPointLabel);
        
        //遗漏
        self.missPointLabel = LotteryTrianglePointView(frame: CGRect(x: self.selectPointLabel.frame.minX, y: BALL_WIDTH*(0.25+0.8), width: self.selectPointLabel.frame.width, height:  self.selectPointLabel.frame.height));
        self.addSubview(self.missPointLabel);
//        self.missPointLabel.text = "遗漏";
        self.missPointLabel.isHidden = true;

        
        //球，遗漏
        for i in 0..<11 {
            let ballView = LotteryBaseBallView(frame: CGRect(x: BALL_WIDTH*0.3*CGFloat(i%6+2) + BALL_WIDTH*CGFloat(i%6+1), y: BALL_WIDTH*CGFloat(i/6)*1.8, width: BALL_WIDTH, height: BALL_WIDTH), ballColor: BallColor.red);
            ballView.setTitle(CommonUtil.toBallNumberString(i: i+1), for: .normal);
            ballView.tag = i;
            self.addSubview(ballView);
            ballView.addTarget(self, action: #selector(ballSelectAction(ballView:)), for: .touchUpInside);
            self.ballViewArray.append(ballView);
            
            let missLabel = D11MissLabel(frame: CGRect(x: ballView.frame.minX, y: ballView.frame.maxY, width: ballView.frame.width, height: ballView.frame.height/2));
            self.addSubview(missLabel);
            missLabel.text = "--";
            self.missLabelArray.append(missLabel);
        }
        
        //全选
        self.selectAllButton = D11SelectAllButton(frame: CGRect(x: BALL_WIDTH*0.3*CGFloat(11%6+2) + BALL_WIDTH*CGFloat(11%6+1), y: BALL_WIDTH*CGFloat(11/6)*1.8+BALL_WIDTH*0.15, width: BALL_WIDTH, height: BALL_WIDTH*0.7));
        self.addSubview(self.selectAllButton);
        self.selectAllButton.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectAllAction() {
        self.clearAction();
        for i in 0..<11 {
            self.ballNumberArray.append(i+1);
        }
        self.updateBallSelection();
    }
    
}
