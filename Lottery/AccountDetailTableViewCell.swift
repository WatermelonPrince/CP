//
//  AccountDetailTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class AccountDetailTableViewCell: LotteryBaseTableViewCell {
    var descriptionLabel: UILabel!;
    var timeLabel: UILabel!;
    var numberLabel: UILabel!;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        
        self.descriptionLabel = UILabel(frame: CGRect(x: 20, y: 7, width: SCREEN_WIDTH/2, height: 25));
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 16);
        self.descriptionLabel.textColor = COLOR_FONT_TEXT;
        self.contentView.addSubview(self.descriptionLabel);
        
        self.timeLabel = UILabel(frame: CGRect(x: self.descriptionLabel.frame.minX, y: self.descriptionLabel.frame.maxY, width: self.descriptionLabel.frame.width, height: self.descriptionLabel.frame.height));
        self.timeLabel.font = UIFont.systemFont(ofSize: 14);
        self.timeLabel.textColor = COLOR_FONT_SECONDARY;
        self.contentView.addSubview(self.timeLabel);
        
        self.numberLabel = UILabel(frame: CGRect(x: SCREEN_WIDTH/2, y: 7, width: SCREEN_WIDTH/2-20, height: self.frame.height));
        self.numberLabel.font = UIFont.systemFont(ofSize: 16);
        self.numberLabel.textAlignment = .right;
        self.contentView.addSubview(self.numberLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(bill: Bill) {
        if (bill.amount == nil) {
            return;
        }
        self.descriptionLabel.text = bill.typeContent;
        self.timeLabel.text = bill.createTimeContent;
        var prefixString = "";
        if (bill.amount! > 0.00) {
            prefixString = "+"
           self.numberLabel.textColor = COLOR_RED;
        } else if (bill.amount! < 0.00) {
            self.numberLabel.textColor = COLOR_WECHAT;
        } else if (bill.amount! == 0) {
            self.numberLabel.textColor = COLOR_FONT_TEXT;
        }
        self.numberLabel.text = prefixString + CommonUtil.formatDoubleString(double: bill.amount!) + "元";
    }

}
