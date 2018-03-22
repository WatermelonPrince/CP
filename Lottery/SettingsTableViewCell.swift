//
//  SettingsTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class SettingsTableViewCell: LotteryBaseTableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.textLabel?.font = UIFont.systemFont(ofSize: 15);
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 15);
        self.textLabel?.textColor = COLOR_FONT_TEXT;
        self.detailTextLabel?.textColor = COLOR_FONT_SECONDARY;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
