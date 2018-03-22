//
//  DPCOrderBottomMultipleBarTermView.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DPCBottomMultipleBarTermButton: OrderBottomMultipleBarBaseButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.mainLabel = UILabel(frame: CGRect(x: 0, y: 5, width: self.frame.width, height: self.frame.height/2 - 5));
        self.mainLabel.textColor = COLOR_FONT_TEXT;
        self.mainLabel.textAlignment = .center;
        self.mainLabel.font = UIFont.systemFont(ofSize: 15);
        self.addSubview(self.mainLabel);
        
        self.subLabel = UILabel(frame: CGRect(x: 0, y: self.mainLabel.frame.maxY, width: self.frame.width, height: self.frame.height/2));
        self.subLabel.textColor = COLOR_FONT_SECONDARY;
        self.subLabel.textAlignment = .center;
        self.subLabel.font = UIFont.systemFont(ofSize: 12);
        self.addSubview(self.subLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DPCOrderBottomMultipleBarTermView: OrderBottomMultipleBarTermView {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.leftButton = DPCBottomMultipleBarTermButton(frame: CGRect(x: 0, y: 0, width: self.frame.width/3, height: self.frame.height));
        self.addSubview(self.leftButton);
        self.middleButton = DPCBottomMultipleBarTermButton(frame: CGRect(x: self.frame.width/3, y: 0, width: self.frame.width/3, height: self.frame.height));
        self.addSubview(self.middleButton);
        self.rightButton = DPCBottomMultipleBarTermButton(frame: CGRect(x: self.frame.width*2/3, y: 0, width: self.frame.width/3, height: self.frame.height));
        self.addSubview(self.rightButton);
        self.setData();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData() {
        self.leftButton.mainLabel.text = "追一个月";
        self.leftButton.subLabel.text = "追14期";
        self.leftButton.textInt = 14;
        self.middleButton.mainLabel.text = "追三个月";
        self.middleButton.subLabel.text = "追40期";
        self.middleButton.textInt = 40;
        self.rightButton.mainLabel.text = "最大";
        self.rightButton.subLabel.text = "追154期";
        self.rightButton.textInt = 154;
    }

}
