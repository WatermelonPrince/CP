//
//  OrderBottomInfoBarView.swift
//  Lottery
//
//  Created by DTY on 17/2/6.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderBottomInfoBarView: UIView {

    var payButton: UIButton!;
    var amount: Double!;
    var amountLabel: UILabel!;
    var infoLabel: UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        
        //付款按钮
        self.payButton = BoardBottomBarBaseButton(frame: CGRect(x: self.frame.width-60-10, y: 5, width: 60, height: self.frame.height-5*2));
        self.payButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_RED), for: .normal);
        self.payButton.setTitle("付款", for: .normal);
        self.payButton.setTitleColor(COLOR_WHITE, for: .normal);
        self.addSubview(self.payButton);
        
        //总价
        self.amountLabel = UILabel(frame: CGRect(x: self.payButton.frame.width+10+5, y: self.payButton.frame.minY, width: self.frame.width-(self.payButton.frame.width+10+5)*2, height: (self.frame.height-5*2)/2));
        self.amountLabel.textColor = COLOR_RED;
        self.amountLabel.textAlignment = .center;
        self.amountLabel.font = UIFont.systemFont(ofSize: 16);
        self.addSubview(self.amountLabel);
        
        //信息
        self.infoLabel = UILabel(frame: CGRect(x: self.amountLabel.frame.minX, y: self.amountLabel.frame.maxY+5, width: self.amountLabel.frame.width, height: self.amountLabel.frame.height-5));
        self.infoLabel.textColor = COLOR_FONT_SECONDARY;
        self.infoLabel.textAlignment = .center;
        self.infoLabel.font = UIFont.systemFont(ofSize: 12);
        self.addSubview(self.infoLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(orderNumber: Int, termNumer: Int, multipleNumer: Int, amount: Int) {
        self.amount = Double(amount);
        self.amountLabel.text = "共\(amount)元";
        self.infoLabel.text = "\(orderNumber)注\(termNumer)期\(multipleNumer)倍";
    }

}
