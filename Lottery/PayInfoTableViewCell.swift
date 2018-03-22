//
//  PayInfoTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/11.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PayInfoTableViewCell: LotteryBaseTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        self.textLabel?.font = UIFont.systemFont(ofSize: 14);
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 15);
        self.textLabel?.textColor = COLOR_FONT_TEXT;
        self.detailTextLabel?.textColor = COLOR_FONT_TEXT;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
