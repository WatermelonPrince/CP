//
//  LotteryLoginView.swift
//  Lottery
//
//  Created by DTY on 17/1/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LoginBaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.layer.cornerRadius = 5;
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16);
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30);
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LotteryLoginView: UIView {
    var wechatLoginButton: UIButton!;
    var mobileLoginButton: UIButton!;
    

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //DescriptionLabel
        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 30, width: self.frame.width, height: 20));
        descriptionLabel.textAlignment = .center;
        descriptionLabel.textColor = COLOR_FONT_SECONDARY;
        descriptionLabel.font = UIFont.systemFont(ofSize: K_FONT_SIZE);
        descriptionLabel.text = "请选择登录方式";
        self.addSubview(descriptionLabel);
        
        //微信
        self.wechatLoginButton = LoginBaseButton(frame: CGRect(x: 30, y: descriptionLabel.frame.maxY+30, width: self.frame.width-30*2, height: 50));
        self.wechatLoginButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_WECHAT), for: .normal);
        self.wechatLoginButton.setTitle("微信登录", for: .normal);
        self.wechatLoginButton.setImage(UIImage(named: "icon_login_wechat"), for: .normal);
        self.addSubview(self.wechatLoginButton);
        
        //手机号
        self.mobileLoginButton = LoginBaseButton(frame: CGRect(x: self.wechatLoginButton.frame.minX, y: self.wechatLoginButton.frame.maxY+30, width: self.wechatLoginButton.frame.width, height: self.wechatLoginButton.frame.height));
        self.mobileLoginButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_RED), for: .normal);
        self.mobileLoginButton.setTitle("手机号登录", for: .normal);
        self.mobileLoginButton.setImage(UIImage(named: "icon_login_mobile"), for: .normal);
        self.addSubview(self.mobileLoginButton);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
