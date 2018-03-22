//
//  LotteryBaseBallView.swift
//  Lottery
//
//  Created by DTY on 17/1/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

enum BallColor {
    case red;
    case blue;
}//MARK:选球的基类
class LotteryBaseBallView: UIButton {
    
    var ballColor: BallColor!;
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                if (self.ballColor == .red) {
                    self.layer.borderColor = COLOR_RED.cgColor;
                } else {
                    self.layer.borderColor = COLOR_BLUE.cgColor;
                }
            } else {
                self.layer.borderColor = COLOR_BORDER.cgColor;
            }
        }
    }

    init(frame: CGRect, ballColor: BallColor) {
        super.init(frame: frame);
        self.ballColor = ballColor;
        
        self.backgroundColor = COLOR_WHITE;
        self.clipsToBounds = true;
        self.layer.cornerRadius = self.frame.width/2;
        self.layer.borderWidth = DIMEN_BORDER;
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.titleLabel?.font = UIFont.systemFont(ofSize: self.frame.width*0.4);
                
        self.setTitleColor((COLOR_WHITE), for: .selected);
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_WHITE), for: .normal);
        
        var ballUIColor = COLOR_RED;
        if (ballColor == .blue) {
            ballUIColor = COLOR_BLUE;
        }
        
        self.setTitleColor(ballUIColor, for: .normal);
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: ballUIColor), for: .selected);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK:
    func changeBlueColor() {
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BLUE), for: .selected);
        self.setTitleColor(COLOR_BLUE, for: .normal);
        self.layer.borderColor = COLOR_BLUE.cgColor;
    }
    
    func changeWhiteGround() {
        self.isSelected = false;
        self.layer.borderColor = COLOR_WHITE.cgColor;
    }

}
