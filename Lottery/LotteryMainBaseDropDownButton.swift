//
//  LotteryMainBaseDropDownButton.swift
//  Lottery
//
//  Created by DTY on 17/2/10.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryMainBaseDropDownButton: UIButton {
    var leftLabel: UILabel!;
    var gameNameLabel: UILabel!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.leftLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height));
        self.leftLabel.text = "玩\n法";
        self.leftLabel.textColor = COLOR_WHITE;
        self.leftLabel.font = UIFont.systemFont(ofSize: 11);
        self.leftLabel.numberOfLines = 2;
        self.addSubview(self.leftLabel);
        
        self.gameNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.height));
        self.gameNameLabel.layer.cornerRadius = 3;
        self.gameNameLabel.layer.borderColor = COLOR_WHITE.cgColor;
        self.gameNameLabel.layer.borderWidth = 0.5;
        self.gameNameLabel.textColor = COLOR_WHITE;
        self.gameNameLabel.font = UIFont.systemFont(ofSize: 16);
        self.gameNameLabel.textAlignment = .center;
        self.addSubview(self.gameNameLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(name: String, show: Bool) {
//        let gameNameAttributedString = NSMutableAttributedString();
//        let dictAttr0 = [NSForegroundColorAttributeName: COLOR_WHITE];
//        let attr0 = NSAttributedString(string: name, attributes: dictAttr0);
//        gameNameAttributedString.append(attr0);
//        let dictAttr1 = [NSForegroundColorAttributeName: COLOR_YELLOW];
//        var attr1 = NSAttributedString(string: " ▼", attributes: dictAttr1);
//        if (show) {
//            attr1 = NSAttributedString(string: " ▲", attributes: dictAttr1);
//        }
//        gameNameAttributedString.append(attr1);
//        self.gameNameLabel.attributedText = gameNameAttributedString;
        if (show != true) {
            self.gameNameLabel.text = name + " ▼";
        } else {
            self.gameNameLabel.text = name + " ▲";
        }
        self.gameNameLabel.sizeToFit();
        self.gameNameLabel.frame.size.height = self.frame.height;
        self.gameNameLabel.frame.size.width += 20;
        self.gameNameLabel.frame.origin.x = self.frame.width/2 - self.gameNameLabel.frame.width/2 + 10;
        self.leftLabel.frame.origin.x = self.gameNameLabel.frame.origin.x - 5 - 12;
    }
}
