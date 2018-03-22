//
//  MineTableHeaderView.swift
//  Lottery
//
//  Created by DTY on 17/1/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineBaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setTitleColor(COLOR_BLACK, for: .normal);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_WHITE), for: .normal);
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_BORDER), for: .highlighted);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MineTableHeaderView: UIView {
    var avatarButton: UIButton!;
    var nickNameButton: UIButton!;
    var balanceButton: UIButton!;
    var redPacketButton: UIButton!;
    var chargeButton: UIButton!;
    var withdrawButton: UIButton!;
    var groundView: UIView!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        //头像
        self.avatarButton = UIButton(frame: CGRect(x: 10, y: 20, width: 70, height: 70));
        self.avatarButton.setImage(UIImage(named: "icon_avatar"), for: .normal);
        self.addSubview(self.avatarButton);
        
        //昵称
        self.nickNameButton = UIButton(frame: CGRect(x: self.avatarButton.frame.maxX+10, y: self.avatarButton.frame.minY, width: self.frame.width-200, height: self.avatarButton.frame.height/2));
        self.nickNameButton.contentHorizontalAlignment = .left;
        self.nickNameButton.setTitleColor(COLOR_FONT_TEXT, for: .normal);
        self.nickNameButton.setTitleColor(COLOR_BROWN, for: .highlighted);
        self.nickNameButton.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        self.addSubview(self.nickNameButton);
        
        //余额
        self.balanceButton = UIButton(frame: CGRect(x: self.nickNameButton.frame.minX, y: self.nickNameButton.frame.maxY, width: self.nickNameButton.frame.width, height: self.avatarButton.frame.height/2));
        self.balanceButton.contentHorizontalAlignment = .left;
        self.addSubview(self.balanceButton);
        
        //红包
        self.redPacketButton = UIButton(frame: CGRect(x:self.frame.width-100, y: self.avatarButton.frame.minY+self.avatarButton.frame.height/4-10, width: 120, height: self.avatarButton.frame.height/2));
        self.redPacketButton.clipsToBounds = true;
        self.redPacketButton.layer.cornerRadius = redPacketButton.frame.height/2;
        self.redPacketButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_YELLOW), for: .normal);
        let redPacketImageView = UIImageView(frame: CGRect(x: self.redPacketButton.frame.height/2-5, y: (self.redPacketButton.frame.height-15)/2, width: 15, height: 15));
        redPacketImageView.image = UIImage(named: "icon_small_redpacket");
        self.redPacketButton.addSubview(redPacketImageView);
        self.redPacketButton.setTitleColor(COLOR_BLACK, for: .normal);
        self.redPacketButton.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.addSubview(self.redPacketButton);
        
        //横分割线
        let horizontalSeparatorLine = UIView(frame: CGRect(x: 0, y: self.avatarButton.frame.maxY+20, width: self.frame.width, height: 0.5));
        horizontalSeparatorLine.backgroundColor = COLOR_BORDER;
        self.addSubview(horizontalSeparatorLine);
        
        //充值
        self.chargeButton = MineBaseButton(frame: CGRect(x: 0, y: horizontalSeparatorLine.frame.maxY, width: self.frame.width/2, height: 50));
        self.chargeButton.setTitle("充值", for: .normal);
        self.addSubview(self.chargeButton);
        
        //竖分割线
        let separatorLine = UIView(frame: CGRect(x: self.chargeButton.frame.maxX-0.5, y: self.chargeButton.frame.minY+self.chargeButton.frame.height/4, width: 0.5, height: self.chargeButton.frame.height/2));
        separatorLine.backgroundColor = COLOR_BORDER;
        self.addSubview(separatorLine);
        
        //提现
        self.withdrawButton = MineBaseButton(frame: CGRect(x: self.frame.width/2, y: self.chargeButton.frame.minY, width: self.chargeButton.frame.width, height: self.chargeButton.frame.height));
        self.withdrawButton.setTitle("提现", for: .normal);
        self.addSubview(self.withdrawButton);
        
        //GroundView
        self.groundView = UIView(frame: CGRect(x: 0, y: self.chargeButton.frame.maxY, width: self.frame.width, height: 25));
        self.groundView.backgroundColor = COLOR_GROUND;
        self.groundView.layer.borderColor = COLOR_BORDER.cgColor;
        self.groundView.layer.borderWidth = 0.5;
        self.addSubview(self.groundView);
        
        self.setBalance(balance: 0.00);
        self.setRedPacketCount(count: 0);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUser(user: User?) {
        //昵称
        var nickNameContent = "登录/注册";
        if (user?.name != nil) {
           nickNameContent = (user?.name)!;
        }
        self.nickNameButton.setTitle(nickNameContent, for: .normal);
    }
    
    func setBalance(balance: Double) {
        //余额
        let balanceAttString = NSMutableAttributedString();
        balanceAttString.append(NSAttributedString(string: "余额 ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: COLOR_FONT_SECONDARY]));
        balanceAttString.append(NSAttributedString(string: CommonUtil.formatDoubleString(double: balance), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: COLOR_RED]));
        balanceAttString.append(NSAttributedString(string: " 元 >", attributes:[NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: COLOR_FONT_SECONDARY]));
        self.balanceButton.setAttributedTitle(balanceAttString, for: .normal);
    }
    
    func setRedPacketCount(count: Int) {
        //红包
        self.redPacketButton.setTitle("  红包\(count)个", for: .normal);
    }

}
