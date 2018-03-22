//
//  WithdrawTextFieldView.swift
//  Lottery
//
//  Created by DTY on 2017/4/6.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class WithdrawTextFieldView: LotteryButtonTextFieldView {
    var yuanLabel: UILabel!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.label.text = "提现金额：";
        self.label.font = UIFont.systemFont(ofSize: 14);
        
        self.textField.frame.size.width = 120;
        self.textField.placeholder = "请输入提现金额";
        self.textField.keyboardType = .decimalPad;
        self.textField.clearButtonMode = .never;
        self.textField.font = UIFont.boldSystemFont(ofSize: 14);
        
        //Button
        if (SCREEN_WIDTH<=320) {
            self.button.frame = CGRect(x: self.button.frame.minX + 45, y: self.button.frame.minY, width: self.button.frame.width - 35, height: self.button.frame.height);
        }
        
        //元
        self.yuanLabel = UILabel(frame: CGRect(x: self.textField.frame.maxX + 2, y: self.textField.frame.minY, width: 20, height: self.textField.frame.height));
        self.yuanLabel.textColor = COLOR_FONT_TEXT;
        self.yuanLabel.font = UIFont.systemFont(ofSize: 14);
        self.addSubview(self.yuanLabel);
        self.yuanLabel.text = "元";
        
        //Button
        self.button.setTitle("全部提现", for: .normal);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
