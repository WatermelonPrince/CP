//
//  BankCardTextFieldView.swift
//  Lottery
//
//  Created by DTY on 2017/5/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
class BankCardBaseTextFieldView: LotteryBaseTextFieldView {
    
    var button: UIButton!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.textField.frame.size.width -= 35;
        self.textField.keyboardType = .numberPad;
        
        //Button
        self.button = UIButton(type: .infoLight);
        self.button.frame = CGRect(x: self.frame.width - 25 - 20, y: (self.frame.height-22)/2, width: 20, height: 20);
        self.addSubview(self.button);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BankCardTextFieldView: BankCardBaseTextFieldView {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.label.text = "银行卡号：";
        self.textField.placeholder = "输入银行卡号";
        
        self.button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonAction() {
        LotteryRoutes.routeURLString(HTTPConstants.HELP_BANKCARD);
    }

}
