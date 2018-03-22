//
//  LotteryBallBoardBottomBarView.swift
//  Lottery
//
//  Created by DTY on 17/1/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class BoardBottomBarBaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.layer.cornerRadius = 3;
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LotteryBallBoardBottomBarView: UIView {
    var machineSelectionButton: UIButton!;
    var clearButton: UIButton!;
    var confirmButton: UIButton!;
    var totalLabel: UILabel!;
    var priceLabel: UILabel!;
    let buttonWidth:CGFloat = 60;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        let borderView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0.5));
        borderView.backgroundColor = COLOR_BORDER;
        self.addSubview(borderView);
        
        //机选
        self.machineSelectionButton = BoardBottomBarBaseButton(frame: CGRect(x: 10, y: 5, width: self.buttonWidth, height: self.frame.height-5*2));
        self.machineSelectionButton.setTitle("机选", for: .normal);
        self.machineSelectionButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_YELLOW), for: .normal);
        self.machineSelectionButton.setTitleColor(COLOR_FONT_TEXT, for: .normal);
        self.addSubview(self.machineSelectionButton);
        
        //清空
        self.clearButton = BoardBottomBarBaseButton(frame: self.machineSelectionButton.frame);
        self.clearButton.setTitle("清空", for: .normal);
        self.clearButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BORDER), for: .normal);
        self.clearButton.setTitleColor(COLOR_FONT_SECONDARY, for: .normal);
        self.addSubview(self.clearButton);
        self.clearButton.isHidden = true;
        
        //确认
        self.confirmButton = BoardBottomBarBaseButton(frame: CGRect(x: self.frame.width-10-self.buttonWidth, y: self.machineSelectionButton.frame.minY, width: self.buttonWidth, height: self.machineSelectionButton.frame.height));
        self.confirmButton.setTitle("确认", for: .normal);
        self.confirmButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_RED), for: .normal);
        self.confirmButton.setTitleColor(COLOR_WHITE, for: .normal);
        self.addSubview(self.confirmButton);
        
        //总数
        self.totalLabel = UILabel(frame: CGRect(x: self.machineSelectionButton.frame.maxX, y: self.machineSelectionButton.frame.minY, width: self.frame.width/2-self.machineSelectionButton.frame.maxX, height: self.machineSelectionButton.frame.height));
        self.totalLabel.textColor = COLOR_FONT_TEXT;
        self.totalLabel.font = UIFont.systemFont(ofSize: 15);
        self.totalLabel.textAlignment = .right;
        self.addSubview(self.totalLabel);
        
        //价格
        self.priceLabel = UILabel(frame: CGRect(x: self.totalLabel.frame.maxX+5, y: self.machineSelectionButton.frame.minY, width: self.totalLabel.frame.width, height: self.machineSelectionButton.frame.height));
        self.priceLabel.textColor = COLOR_RED;
        self.priceLabel.font = UIFont.systemFont(ofSize: 16);
        self.addSubview(self.priceLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(totalNumber: Int) {
        self.totalLabel.text = "共\(totalNumber)注";
        let priceNumber = totalNumber*2;
        self.priceLabel.text = "\(priceNumber)元";
    }

}
