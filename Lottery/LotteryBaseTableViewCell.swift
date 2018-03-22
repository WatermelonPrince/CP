//
//  LotteryBaseTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/1.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = COLOR_WHITE;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
