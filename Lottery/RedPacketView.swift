//
//  RedPacketView.swift
//  Lottery
//
//  Created by DTY on 2017/4/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class RedPacketView: UIImageView {
    var amountLabel: UILabel!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.image = UIImage(named: "icon_redpacket");
        
        self.amountLabel = UILabel(frame: CGRect(x: 5, y: self.frame.height*0.25, width: self.frame.width-5*2, height: self.frame.height*0.75));
        self.amountLabel.textColor = COLOR_YELLOW;
        self.amountLabel.numberOfLines = 0;
        self.amountLabel.textAlignment = .center;
        self.addSubview(self.amountLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(amount: Double, condition: Double?) {
        self.amountLabel.font = UIFont.boldSystemFont(ofSize: 15);
        self.amountLabel.text = CommonUtil.formatDoubleString(double: amount) + "\n元";
        if (condition != nil) {
            self.amountLabel.font = UIFont.boldSystemFont(ofSize: 14);
            self.amountLabel.text = "满" + CommonUtil.formatConditionRedPacketString(double: condition!) + "\n减" + CommonUtil.formatConditionRedPacketString(double: amount) + "元";
        }
    }
}
