//
//  MineOrderDetailTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/5.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineOrderDetailTableViewCell: LotteryBaseTableViewCell {
    var leftLabel: UILabel!;
    var rightLabel: UILabel!;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        self.leftLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 100, height: 35));
        self.contentView.addSubview(self.leftLabel);
        self.rightLabel = UILabel(frame: CGRect(x: self.leftLabel.frame.maxX, y: self.leftLabel.frame.minY, width: SCREEN_WIDTH-self.leftLabel.frame.maxX-15, height: self.leftLabel.frame.height));
        self.rightLabel.numberOfLines = 0;
        self.contentView.addSubview(self.rightLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
