//
//  MobileTextFieldView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MobileTextFieldView: LotteryBaseTextFieldView {
 
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.label.text = "手机号：";
        self.textField.placeholder = "请输入您的手机号";
        self.textField.keyboardType = .numberPad;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
