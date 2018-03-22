//
//  RedPacketTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/20.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class RedPacketTableViewCell: LotteryBaseTableViewCell {
    var redPacketView: RedPacketView!
    var balanceLabel: UILabel!;
    var expireLabel: UILabel!;
    var nameLabel: UILabel!;
    var descriptionLabel: UILabel!;
    var typeLabel: UILabel!;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        
        self.redPacketView = RedPacketView(frame: CGRect(x: 20, y: 20, width: 80, height: 80));
        self.contentView.addSubview(self.redPacketView);
        
        self.balanceLabel = UILabel(frame: CGRect(x: self.redPacketView.frame.maxX + 10, y: self.redPacketView.frame.minY, width: SCREEN_WIDTH-self.redPacketView.frame.maxX-20, height: 20));
        self.balanceLabel.font = UIFont.boldSystemFont(ofSize: 16);
        self.balanceLabel.textColor = COLOR_FONT_TEXT;
        self.contentView.addSubview(self.balanceLabel);
        
        self.expireLabel = UILabel(frame: CGRect(x: self.balanceLabel.frame.minX, y: self.balanceLabel.frame.maxY, width: self.balanceLabel.frame.width, height: self.balanceLabel.frame.height));
        self.expireLabel.font = UIFont.systemFont(ofSize: 14);
        self.expireLabel.textColor = COLOR_RED;
        self.contentView.addSubview(self.expireLabel);
        
        self.nameLabel = UILabel(frame: CGRect(x: self.balanceLabel.frame.minX, y: self.expireLabel.frame.maxY, width: self.balanceLabel.frame.width, height: self.balanceLabel.frame.height));
        self.nameLabel.font = UIFont.systemFont(ofSize: 13);
        self.nameLabel.textColor = COLOR_FONT_SECONDARY;
        self.contentView.addSubview(self.nameLabel);
        
        self.descriptionLabel = UILabel(frame: CGRect(x: self.balanceLabel.frame.minX, y: self.nameLabel.frame.maxY, width: self.balanceLabel.frame.width, height: self.balanceLabel.frame.height));
        self.descriptionLabel.font = self.nameLabel.font;
        self.descriptionLabel.textColor = self.nameLabel.textColor;
        self.contentView.addSubview(self.descriptionLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDataForGame(redPacket: RedPacket) {
        if (redPacket.balance == nil) {
            return;
        }
        self.redPacketView.setData(amount: redPacket.amount!, condition: redPacket.condition);
        self.balanceLabel.text = "余额：" + CommonUtil.formatDoubleString(double: redPacket.balance!) + "元";
        if (redPacket.status == RedPacket.INIT) {
            self.expireLabel.text = redPacket.startTimeContent!;
            self.expireLabel.textColor = COLOR_FONT_TEXT;
        } else if (redPacket.status == RedPacket.AVAILABLE){
            if (redPacket.usable == false) {
                self.expireLabel.text = "不可用红包";
            } else {
                self.expireLabel.text = redPacket.validTimeContent!;
            }
            self.expireLabel.textColor = COLOR_RED;
            
        }
        self.nameLabel.text = redPacket.name;
        self.descriptionLabel.text = redPacket.description;
        
        if (redPacket.usable == true) {
            self.contentView.alpha = 1;
            self.isUserInteractionEnabled = true;
        } else {
            self.contentView.alpha = 0.5;
            self.isUserInteractionEnabled = false;
        }
        
    }
    
    func setData(redPacket: RedPacket) {
        if (redPacket.balance == nil) {
            return;
        }
        self.redPacketView.setData(amount: redPacket.amount!, condition: redPacket.condition);
        self.balanceLabel.text = "余额：" + CommonUtil.formatDoubleString(double: redPacket.balance!) + "元";
        if (redPacket.status == RedPacket.INIT) {
            self.balanceLabel.text = "派发时间：" + redPacket.startTimeContent!;
            self.balanceLabel.textColor = COLOR_RED;
            self.expireLabel.text = "余额：" + CommonUtil.formatDoubleString(double: redPacket.balance!) + "元";
            self.expireLabel.textColor = COLOR_FONT_TEXT;
        } else if (redPacket.status == RedPacket.AVAILABLE){
            self.expireLabel.text = redPacket.validTimeContent!;
            self.expireLabel.textColor = COLOR_RED;
            
        } else if (redPacket.status == RedPacket.RUNOUT) {
            self.expireLabel.text = "已用完";
            self.expireLabel.textColor = COLOR_FONT_SECONDARY;
        } else if (redPacket.status == RedPacket.OVERDUE) {
            self.expireLabel.text = "已过期";
            self.expireLabel.textColor = COLOR_FONT_SECONDARY;
        }
        self.nameLabel.text = redPacket.name;
        self.descriptionLabel.text = redPacket.description;
        
        if (redPacket.status == RedPacket.RUNOUT || redPacket.status == RedPacket.OVERDUE) {
            self.contentView.alpha = 0.5;
        } else {
            self.contentView.alpha = 1;
        }
    }

}
