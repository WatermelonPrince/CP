//
//  OrderItemTableHeaderView.swift
//  Lottery
//
//  Created by DTY on 17/2/3.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderItemTableHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        let separatorLine = UIView(frame: CGRect(x: 0, y: self.frame.height-0.5, width: self.frame.width, height: 0.5));
        separatorLine.backgroundColor = COLOR_BORDER;
        self.addSubview(separatorLine);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
