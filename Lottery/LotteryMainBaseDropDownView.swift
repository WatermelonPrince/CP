//
//  LotteryMainBaseDropDownView.swift
//  Lottery
//
//  Created by DTY on 17/2/10.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryMainBaseDropDownViewSelectionButton: LotteryBaseSelectionButton {
    var addPrizeLabel: UILabel!;
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14);
        
        //加奖
        self.addPrizeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 11, height: self.frame.height));
        self.addPrizeLabel.font = UIFont.systemFont(ofSize: 10);
        self.addPrizeLabel.backgroundColor = COLOR_RED;
        self.addPrizeLabel.textColor = COLOR_WHITE;
        self.addPrizeLabel.numberOfLines = 2;
        self.addSubview(self.addPrizeLabel);
        self.addPrizeLabel.text = "加\n奖";
        self.addPrizeLabel.isHidden = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LotteryMainBaseDropDownView: UIView {
    var gameNameArray = Array<String>();
    var buttonArray = Array<LotteryMainBaseDropDownViewSelectionButton>();
    var selectedButtonInt = 0;
    var maskButton: UIButton!;
    
    init(frame: CGRect, gameNameArray: Array<String>) {
        super.init(frame: frame);
        self.gameNameArray = gameNameArray;
        
        //遮罩
        self.maskButton = UIButton(frame: self.frame);
        self.addSubview(self.maskButton);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonAction(_ button: LotteryMainBaseDropDownViewSelectionButton) {
        for button in self.buttonArray {
            button.isSelected = false;
        }
        self.selectedButtonInt = button.tag;
        button.isSelected = true;
        
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "DropDownButtonChange"), object: self, userInfo: nil));
    }
    
    func resetAction() {
        for button in self.buttonArray {
            if (button.tag == self.selectedButtonInt) {
                button.isSelected = true;
            } else {
                button.isSelected = false;
            }
            
        }
    }
    

}
