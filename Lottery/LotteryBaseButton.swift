//
//  LotteryBaseButton.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_RED), for: .normal);
        self.layer.cornerRadius = 3;
        self.setTitleColor(COLOR_WHITE, for: .normal);
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
