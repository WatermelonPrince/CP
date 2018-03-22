//
//  AccountDetailTableHeaderView.swift
//  Lottery
//
//  Created by DTY on 2017/4/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class AccountDetailBaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textColor = COLOR_FONT_TEXT;
        self.font = UIFont.systemFont(ofSize: 15);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AccountDetailTableHeaderView: UIView {
    var balanceLabel: AccountDetailBaseLabel!;
    var freezeLabel: AccountDetailBaseLabel!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        self.balanceLabel = AccountDetailBaseLabel(frame: CGRect(x: 20, y: 10, width: self.frame.width-20*2, height: 30));
        self.addSubview(self.balanceLabel);
        
        self.freezeLabel = AccountDetailBaseLabel(frame: CGRect(x: self.balanceLabel.frame.minX, y: self.balanceLabel.frame.maxY, width: self.balanceLabel.frame.width, height: self.balanceLabel.frame.height));
        self.addSubview(self.freezeLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(balanceAmount: Double, freezeAmount: Double) {
        let balanceAttString = NSMutableAttributedString(string: "账户余额：");
        let balanceNumberAttString = NSMutableAttributedString(string: CommonUtil.formatDoubleString(double: balanceAmount) + "元", attributes: [NSForegroundColorAttributeName:COLOR_RED]);
        balanceAttString.append(balanceNumberAttString);
        self.balanceLabel.attributedText = balanceAttString;
        self.freezeLabel.text = "提现中金额：" + CommonUtil.formatDoubleString(double: freezeAmount) + "元";
    }
}
