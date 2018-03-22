//
//  DPCBallBoardView.swift
//  Lottery
//
//  Created by DTY on 17/1/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DPCBallBoardView: LotteryBaseBallBoardView {

    init(frame: CGRect, ballColor: BallColor, number: Int) {
        super.init(frame: frame);

        for i in 0..<number {
            let ballView = LotteryBaseBallView(frame: CGRect(x: BALL_WIDTH*0.3*CGFloat(i%7+1) + BALL_WIDTH*CGFloat(i%7), y: 5*CGFloat(i/7+1)+BALL_WIDTH*CGFloat(i/7), width: BALL_WIDTH, height: BALL_WIDTH), ballColor: ballColor);
            ballView.setTitle(CommonUtil.toBallNumberString(i: i+1), for: .normal);
            ballView.tag = i;
            self.addSubview(ballView);
            ballView.addTarget(self, action: #selector(ballSelectAction(ballView:)), for: .touchUpInside);
            
            self.ballViewArray.append(ballView);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
