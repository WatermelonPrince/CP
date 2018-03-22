//
//  DLTOrderBottomMultipleBarMainView.swift
//  Lottery
//
//  Created by DTY on 17/2/14.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DLTOrderBottomMultipleBarAddNumberButton: LotteryCheckBoxButton {
    override func checkAction() {
        super.checkAction();
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "AddNumberAction"), object: self, userInfo: nil));
    }
}


class DLTOrderBottomMultipleBarMainView: DPCOrderBottomMultipleBarMainView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        //连续买N期
        let termLeftLabel = OrderBottomMultipleBarBaseLabel(frame: CGRect(x: 10, y: 5, width: 17*3, height: self.frame.height-5*2));
        termLeftLabel.text = "连续买";
        self.addSubview(termLeftLabel);
        
        self.termTextField = OrderBottomMultipleBarBaseTextField(frame: CGRect(x: termLeftLabel.frame.maxX+5, y: termLeftLabel.frame.minY, width: 60, height: termLeftLabel.frame.height));
        self.addSubview(self.termTextField);
        self.termTextField.maxInt = 154;
        
        let termRightLabel = OrderBottomMultipleBarBaseLabel(frame: CGRect(x: self.termTextField.frame.maxX+5, y: termLeftLabel.frame.minY, width: 16, height: termLeftLabel.frame.height));
        termRightLabel.text = "期";
        self.addSubview(termRightLabel);
        
        //投N倍
        let multipleLeftLabel = OrderBottomMultipleBarBaseLabel(frame: CGRect(x: termRightLabel.frame.maxX+10, y: termLeftLabel.frame.minY, width: 16, height: termLeftLabel.frame.height));
        multipleLeftLabel.text = "投";
        self.addSubview(multipleLeftLabel);
        
        self.multipleTextField = OrderBottomMultipleBarBaseTextField(frame: CGRect(x: multipleLeftLabel.frame.maxX+5, y: termLeftLabel.frame.minY, width: self.termTextField.frame.width, height: termLeftLabel.frame.height));
        self.addSubview(self.multipleTextField);
        self.multipleTextField.maxInt = 99999;
        
        let multipleRightLabel = OrderBottomMultipleBarBaseLabel(frame: CGRect(x: self.multipleTextField.frame.maxX+5, y: termLeftLabel.frame.minY, width: 16, height: termLeftLabel.frame.height));
        multipleRightLabel.text = "倍";
        self.addSubview(multipleRightLabel);
        
        //追加
        self.addNumberButton = DLTOrderBottomMultipleBarAddNumberButton(frame: CGRect(x: self.frame.width-90-5, y: self.frame.height/4, width: 90, height: self.frame.height/2));
        self.addSubview(self.addNumberButton);
        self.addNumberButton.descriptionLabel.text = "追加投注";
        
        //separatorLine
        let separatorLine = UIView(frame: CGRect(x: self.addNumberButton.frame.minX - 5, y: 0, width: 0.5, height: self.frame.height));
        separatorLine.backgroundColor = COLOR_BORDER;
        self.addSubview(separatorLine);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
