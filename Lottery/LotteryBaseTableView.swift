//
//  LotteryBaseTableView.swift
//  Lottery
//
//  Created by DTY on 2017/4/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseTableView: UITableView {

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style);
        self.backgroundColor = COLOR_GROUND;
        self.tableFooterView = UIView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
