//
//  PayRedPacketDetailButton.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PayRedPacketDetailButton: UIButton {
    var redPacketView: RedPacketView!;
    var balanceLabel: UILabel!;
    var nameLabel: UILabel!;
    var expireLabel: UILabel!;
    var checkBoxImageView: UIImageView!;
    var redPacket: RedPacket!;
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                self.checkBoxImageView.image = UIImage(named: "icon_selected");
            } else {
                self.checkBoxImageView.image = UIImage(named: "icon_unselected");
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if (isEnabled) {
                self.alpha = 1;
            } else {
                self.alpha = 0.6;
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        let checkBoxImageViewWidth: CGFloat = 25;
        
        self.redPacketView = RedPacketView(frame: CGRect(x: checkBoxImageViewWidth/2, y: checkBoxImageViewWidth/2, width: self.frame.width-checkBoxImageViewWidth, height: self.frame.width-checkBoxImageViewWidth));
        self.redPacketView.amountLabel.font = UIFont.systemFont(ofSize: K_FONT_SIZE+1);
        self.addSubview(self.redPacketView);
        
        self.checkBoxImageView = UIImageView(frame: CGRect(x: self.frame.width-checkBoxImageViewWidth, y: 0, width: checkBoxImageViewWidth, height: checkBoxImageViewWidth));
        self.checkBoxImageView.image = UIImage(named: "icon_unselected");
        self.addSubview(self.checkBoxImageView);
        
        self.balanceLabel = UILabel(frame: CGRect(x: self.redPacketView.frame.minX, y: self.redPacketView.frame.maxY + 2, width: self.redPacketView.frame.width, height: K_FONT_SIZE+2));
        self.balanceLabel.textColor = COLOR_RED;
        self.balanceLabel.font = UIFont.systemFont(ofSize: K_FONT_SIZE);
        self.balanceLabel.textAlignment = .center;
        self.addSubview(self.balanceLabel);
        
        self.nameLabel = UILabel(frame: CGRect(x: self.redPacketView.frame.minX, y: self.balanceLabel.frame.maxY, width: self.redPacketView.frame.width, height: self.balanceLabel.frame.height));
        self.nameLabel.textColor = COLOR_FONT_SECONDARY;
        self.nameLabel.font = UIFont.systemFont(ofSize: K_FONT_SIZE-2);
        self.nameLabel.textAlignment = .center;
        self.addSubview(self.nameLabel);
        
        self.expireLabel = UILabel(frame: CGRect(x: self.redPacketView.frame.minX, y: self.nameLabel.frame.maxY, width: self.redPacketView.frame.width, height: self.balanceLabel.frame.height));
        self.expireLabel.textColor = self.nameLabel.textColor;
        self.expireLabel.font = self.nameLabel.font;
        self.expireLabel.textAlignment = .center;
        self.addSubview(self.expireLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(redPacket: RedPacket) {
        self.redPacket = redPacket;
        self.redPacketView.amountLabel.text = CommonUtil.formatDoubleString(double: redPacket.amount!) + "\n元";
        if (redPacket.condition != nil) {
            self.redPacketView.amountLabel.text = "满" + CommonUtil.formatConditionRedPacketString(double: redPacket.condition!) + "\n减" + CommonUtil.formatConditionRedPacketString(double: redPacket.amount!) + "元";
        }
        self.balanceLabel.text = "剩余:" + CommonUtil.formatDoubleString(double: redPacket.balance!) + "元";
        if (redPacket.usable != true) {
            self.balanceLabel.text = "不可用红包";
        }
        self.nameLabel.text = redPacket.name;
        self.expireLabel.text = redPacket.validTimeContent;
        self.isEnabled = redPacket.usable!;
    }

}
