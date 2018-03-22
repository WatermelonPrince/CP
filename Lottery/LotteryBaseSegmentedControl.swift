//
//  LotteryBaseSegmentedControl.swift
//  Lottery
//
//  Created by DTY on 2017/4/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseSegmentedControl: UISegmentedControl {
    override init(items: [Any]?) {
        super.init(items: items);
        self.selectedSegmentIndex = 0;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setTitleTextAttributes([NSForegroundColorAttributeName : COLOR_FONT_TEXT], for: .normal);
        self.setTitleTextAttributes([NSForegroundColorAttributeName : COLOR_WHITE], for: .selected);
        self.tintColor = COLOR_RED;
        self.backgroundColor = COLOR_WHITE;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
