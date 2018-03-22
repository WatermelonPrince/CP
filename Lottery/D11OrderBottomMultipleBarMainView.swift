//
//  D11OrderBottomMultipleBarMainView.swift
//  Lottery
//
//  Created by DTY on 17/2/28.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11OrderBottomMultipleBarMainView: OrderBottomMultipleBarMainView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //连续买N期
        let termLeftLabel = OrderBottomMultipleBarBaseLabel(frame: CGRect(x: 10, y: 5, width: 17*3, height: self.frame.height-5*2));
        termLeftLabel.text = "连续买";
        self.addSubview(termLeftLabel);
        
        self.termTextField = OrderBottomMultipleBarBaseTextField(frame: CGRect(x: termLeftLabel.frame.maxX+10, y: termLeftLabel.frame.minY, width: self.frame.width*0.2, height: termLeftLabel.frame.height));
        self.addSubview(self.termTextField);
        self.termTextField.maxInt = 999;
        
        let termRightLabel = OrderBottomMultipleBarBaseLabel(frame: CGRect(x: self.termTextField.frame.maxX+10, y: termLeftLabel.frame.minY, width: 16, height: termLeftLabel.frame.height));
        termRightLabel.text = "期";
        self.addSubview(termRightLabel);
        
        //投N倍
        let multipleRightLabel = OrderBottomMultipleBarBaseLabel(frame: CGRect(x: self.frame.width-10-16, y: termLeftLabel.frame.minY, width: 16, height: termLeftLabel.frame.height));
        multipleRightLabel.text = "倍";
        self.addSubview(multipleRightLabel);
        
        self.multipleTextField = OrderBottomMultipleBarBaseTextField(frame: CGRect(x: multipleRightLabel.frame.minX-10-self.termTextField.frame.width, y: termLeftLabel.frame.minY, width: self.termTextField.frame.width, height: termLeftLabel.frame.height));
        self.addSubview(self.multipleTextField);
        self.multipleTextField.maxInt = 99999;
        
        let multipleLeftLabel = OrderBottomMultipleBarBaseLabel(frame: CGRect(x: self.multipleTextField.frame.minX-10-16, y: termLeftLabel.frame.minY, width: 16, height: termLeftLabel.frame.height));
        multipleLeftLabel.text = "投";
        self.addSubview(multipleLeftLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
