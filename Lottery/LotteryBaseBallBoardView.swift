//
//  LotteryBaseBallBoardView.swift
//  Lottery
//
//  Created by DTY on 17/2/22.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseBallBoardView: UIView {
    var ballViewArray = Array<LotteryBaseBallView>();
    var ballNumberArray = Array<Int>();
    
    func ballSelectAction(ballView: LotteryBaseBallView) {
        ballView.isSelected = !ballView.isSelected;
        if (ballView.isSelected) {
            self.ballNumberArray.append(ballView.tag+1);
        } else {
            for i in 0..<self.ballNumberArray.count {
                if (self.ballNumberArray[i] == ballView.tag+1) {
                    self.ballNumberArray.remove(at: i);
                    break;
                }
            }
        }
        
        //发送通知
        self.sendChangeNotification();
    }
    
    func clearAction() {
        for ballView in self.ballViewArray {
            ballView.isSelected = false;
        }
        self.ballNumberArray.removeAll();
        self.sendChangeNotification();
    }
    
    func removeItem(num: Int) {
        for i in self.ballNumberArray.enumerated() {
            if (i.element == num) {
                self.ballViewArray[i.element - 1].isSelected = false;
                self.ballNumberArray.remove(at: i.offset);
                break;
            }
        }
        
    }
//MARK:主要用于机选后更新球的状态
    func updateBallSelection() {
        for ball in self.ballViewArray {
            if (self.ballNumberArray.contains(ball.tag+1)) {
                ball.isSelected = true;
            }
        }
        self.sendChangeNotification();
    }

    func sendChangeNotification() {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "BallNumberChange"), object: self, userInfo: nil));
    }

}
