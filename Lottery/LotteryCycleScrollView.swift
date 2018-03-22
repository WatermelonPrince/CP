//
//  LotteryCycleScrollView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryCycleScrollView: SDCycleScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.autoScrollTimeInterval = 5;
        self.backgroundColor = COLOR_GROUND;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
