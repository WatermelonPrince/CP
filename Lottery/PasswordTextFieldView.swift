//
//  PasswordTextFieldView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PasswordTextFieldView: LotteryBaseTextFieldView {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.label.text = "密码：";
        
        self.textField.placeholder = "请输入密码";
        self.textField.isSecureTextEntry = true;
        self.textField.keyboardType = .asciiCapable;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
