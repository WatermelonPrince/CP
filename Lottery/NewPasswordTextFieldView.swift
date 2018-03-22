//
//  NewPasswordTextFieldView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class NewPasswordTextFieldView: PasswordTextFieldView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textField.placeholder = "请输入6-16位密码";
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
