//
//  D11OrderBottomMultipleBarMultipleView.swift
//  Lottery
//
//  Created by DTY on 17/2/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11OrderBottomMultipleBarMultipleView: OrderBottomMultipleBarMultipleView {
    var leftButton: D11BottomMultipleBarTermButton!;
    var middleButton: D11BottomMultipleBarTermButton!;
    var rightButton: D11BottomMultipleBarTermButton!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.leftButton = D11BottomMultipleBarTermButton(frame: CGRect(x: 0, y: 0, width: self.frame.width/3, height: self.frame.height));
        self.addSubview(self.leftButton);
        self.middleButton = D11BottomMultipleBarTermButton(frame: CGRect(x: self.frame.width/3, y: 0, width: self.frame.width/3, height: self.frame.height));
        self.addSubview(self.middleButton);
        self.rightButton = D11BottomMultipleBarTermButton(frame: CGRect(x: self.frame.width*2/3, y: 0, width: self.frame.width/3, height: self.frame.height));
        self.addSubview(self.rightButton);
        self.setData();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData() {
        self.leftButton.mainLabel.text = "投10倍";
        self.leftButton.textInt = 10;
        self.middleButton.mainLabel.text = "投20倍";
        self.middleButton.textInt = 20;
        self.rightButton.mainLabel.text = "投50倍";
        self.rightButton.textInt = 50;
    }
}
