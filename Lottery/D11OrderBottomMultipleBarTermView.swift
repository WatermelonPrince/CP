//
//  D11OrderBottomMultipleBarTermView.swift
//  Lottery
//
//  Created by DTY on 17/2/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit


class D11BottomMultipleBarTermButton: OrderBottomMultipleBarBaseButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.mainLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height));
        self.mainLabel.textColor = COLOR_FONT_TEXT;
        self.mainLabel.textAlignment = .center;
        self.mainLabel.font = UIFont.systemFont(ofSize: self.frame.width*0.12);
        self.addSubview(self.mainLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class D11OrderBottomMultipleBarTermView: OrderBottomMultipleBarTermView {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.leftButton = D11BottomMultipleBarTermButton(frame: CGRect(x: 0, y: 0, width: self.frame.width/3, height: self.frame.height));
        self.addSubview(self.leftButton);
        self.middleButton = D11BottomMultipleBarTermButton(frame: CGRect(x: self.frame.width/3, y: 0, width: self.frame.width/3, height: self.frame.height));
        self.addSubview(self.middleButton);
        self.rightButton = D11BottomMultipleBarTermButton(frame: CGRect(x: self.frame.width*2/3, y: 0, width: self.frame.width/3, height: self.frame.height));
        self.addSubview(self.rightButton);
        self.setData(maxTimes: 84);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(maxTimes: Int) {
        self.leftButton.mainLabel.text = "追10期";
        self.leftButton.textInt = 10;
        self.middleButton.mainLabel.text = "追20期";
        self.middleButton.textInt = 20;
        self.rightButton.mainLabel.text = "追\(maxTimes)期（1天）";
        self.rightButton.textInt = maxTimes;
    }
    
}

