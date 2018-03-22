//
//  PayRedPacketTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/11.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class PayRedPacketTableViewCell: LotteryBaseTableViewCell {
    var detailButton: UIButton!;
    var leftButton: PayRedPacketDetailButton!;
    var middleButton: PayRedPacketDetailButton!;
    var rightButton: PayRedPacketDetailButton!;
    var moreButton: UIButton!;
    var useRedPacket: RedPacket!;
    var isInitial = true;
    
    var isRedPacketHidden = false {
        didSet {
            self.leftButton.isHidden = isRedPacketHidden;
            self.middleButton.isHidden = isRedPacketHidden;
            self.rightButton.isHidden = isRedPacketHidden;
            self.moreButton.isHidden = isRedPacketHidden;
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        
        self.detailButton = UIButton(frame: CGRect(x: SCREEN_WIDTH-20-100, y: 0, width: 100, height: 20));
        self.detailButton.setTitle("查看红包 ∨", for: .normal);
        self.detailButton.setTitle("查看红包 ∧", for: .selected);
        self.detailButton.setTitleColor(COLOR_BLUE, for: .normal);
        self.detailButton.setTitleColor(CommonUtil.colorWithAlpha(color: COLOR_BLUE, alpha: 0.7), for: .highlighted);
        self.detailButton.titleLabel?.font = UIFont.systemFont(ofSize: 13);
        self.detailButton.contentHorizontalAlignment = .right;
        self.contentView.addSubview(self.detailButton);
        
        let buttonWidth: CGFloat = SCREEN_WIDTH*0.28;
        let marginWidth: CGFloat = (SCREEN_WIDTH-buttonWidth*3)/4
        let buttonHeight: CGFloat = buttonWidth + 30;
        self.leftButton = PayRedPacketDetailButton(frame: CGRect(x: marginWidth, y: self.detailButton.frame.maxY + 10, width: buttonWidth, height: buttonHeight));
        self.contentView.addSubview(self.leftButton);
        self.leftButton.isHidden = true;
        self.leftButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside);
        self.middleButton = PayRedPacketDetailButton(frame: CGRect(x: marginWidth*2 + buttonWidth, y: self.leftButton.frame.minY, width: buttonWidth, height: buttonHeight));
        self.contentView.addSubview(self.middleButton);
        self.middleButton.isHidden = true;
        self.middleButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside);
        self.rightButton = PayRedPacketDetailButton(frame: CGRect(x: marginWidth*3 + buttonWidth*2, y: self.leftButton.frame.minY, width: buttonWidth, height: buttonHeight));
        self.contentView.addSubview(self.rightButton);
        self.rightButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside);
        self.rightButton.isHidden = true;
        
        self.moreButton = UIButton(frame: CGRect(x: SCREEN_WIDTH/2-50, y: self.leftButton.frame.maxY+20, width: 100, height: 20));
        self.moreButton.setTitle("所有红包 >", for: .normal);
        self.moreButton.setTitleColor(COLOR_BLUE, for: .normal);
        self.moreButton.setTitleColor(CommonUtil.colorWithAlpha(color: COLOR_BLUE, alpha: 0.7), for: .highlighted);
        self.moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 13);
        self.contentView.addSubview(self.moreButton);
        self.moreButton.isHidden = true;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(redPacketList: Array<RedPacket>) {
        if (self.isInitial == false) {
            return;
        }
        
        if (redPacketList.count <= 0) {
            return;
        } else if (redPacketList.count == 1) {
            self.middleButton.setData(redPacket: redPacketList[0]);
            self.middleButton.isHidden = false;
            if (redPacketList[0].usable == true) {
                self.middleButton.sendActions(for: .touchUpInside);
            }
        } else if (redPacketList.count == 2) {
            self.leftButton.setData(redPacket: redPacketList[0]);
            self.middleButton.setData(redPacket: redPacketList[1]);
            self.leftButton.isHidden = false;
            self.middleButton.isHidden = false;
            self.leftButton.isSelected = false;
            self.middleButton.isSelected = false;
            if (redPacketList[0].usable == true) {
                self.leftButton.sendActions(for: .touchUpInside);
            }
        } else if (redPacketList.count >= 3) {
            self.leftButton.setData(redPacket: redPacketList[0]);
            self.middleButton.setData(redPacket: redPacketList[1]);
            self.rightButton.setData(redPacket: redPacketList[2]);
            self.leftButton.isHidden = false;
            self.middleButton.isHidden = false;
            self.rightButton.isHidden = false;
            self.leftButton.isSelected = false;
            self.middleButton.isSelected = false;
            self.rightButton.isSelected = false;
            if (redPacketList[0].usable == true) {
                self.leftButton.sendActions(for: .touchUpInside);
            }
        }
        
        if (redPacketList[0].usable != true) {
            self.detailButton.setTitle("无可用红包 ∨", for: .normal);
            self.detailButton.setTitle("无可用红包 ∧", for: .selected);
        } else {
            self.useRedPacket = redPacketList[0];
        }
        
        if (redPacketList.count > 3) {
            self.moreButton.isHidden = false;
        }
        
        self.isInitial = false;
        
    }
    
    func buttonAction(_ button: PayRedPacketDetailButton) {
        let oldState = button.isSelected;
        self.leftButton.isSelected = false;
        self.middleButton.isSelected = false;
        self.rightButton.isSelected = false;
        button.isSelected = !oldState;
        if (button.isSelected) {
            self.useRedPacket = button.redPacket;
        } else {
            self.useRedPacket = nil;
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RedPacketDidSelectAction"), object: self.useRedPacket);
        
    }

}
