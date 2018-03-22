//
//  DantuoIntroButton.swift
//  Lottery
//
//  Created by DTY on 17/3/29.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DantuoIntroButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setTitle("什么是胆拖?", for: .normal);
        self.setTitleColor(COLOR_BLUE, for: .normal);
        self.contentHorizontalAlignment = .left;
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.addTarget(self, action: #selector(dantuoIntroAction), for: .touchUpInside);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dantuoIntroAction() {
        LotteryRoutes.routeURLString(HTTPConstants.HELP_DANTUO);
    }
    
}
