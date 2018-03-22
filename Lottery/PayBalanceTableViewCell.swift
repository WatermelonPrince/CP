//
//  PayBalanceTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/11.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PayBalanceTableViewCell: PayInfoTableViewCell {
    var balanceDetailLabel: UILabel!;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier);
        self.textLabel?.text = "余额抵扣";
        self.balanceDetailLabel = UILabel(frame: CGRect(x: 100, y: 0, width: SCREEN_WIDTH-100-50, height: self.frame.height-5));
        self.balanceDetailLabel.font = self.detailTextLabel?.font;
        self.balanceDetailLabel.textAlignment = .right;
        self.contentView.addSubview(self.balanceDetailLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
