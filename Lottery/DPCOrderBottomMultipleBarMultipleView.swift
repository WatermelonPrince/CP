//
//  DPCOrderBottomMultipleBarMultipleView.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DPCOrderBottomMultipleBarMultipleView: OrderBottomMultipleBarMultipleView {

    var moneyImageView: UIImageView!;
    var descriptionLabel: UILabel!;
    var emptyButton: UIButton!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_GROUND;
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.layer.borderWidth = 0.5;
        
        //moneyImageView
        self.moneyImageView = UIImageView(frame: CGRect(x: 15, y: self.frame.height*0.15, width: self.frame.height*0.7, height: self.frame.height*0.7));
        self.moneyImageView.image = UIImage(named: "icon_order_moneybag");
        self.addSubview(self.moneyImageView);
        
        //DescriptionLabel
        self.descriptionLabel = UILabel(frame: CGRect(x: self.moneyImageView.frame.maxX+10, y: 0, width: 250, height: self.frame.height));
        self.descriptionLabel.textColor = COLOR_FONT_TEXT;
        self.descriptionLabel.font = UIFont.boldSystemFont(ofSize: K_FONT_SIZE);
        self.addSubview(self.descriptionLabel);
        
        //emptyButton
        self.emptyButton = UIButton(frame: CGRect(x: self.frame.width-70-15, y: 5, width: 70, height: self.frame.height-5*2));
        self.emptyButton.clipsToBounds = true;
        self.emptyButton.layer.cornerRadius = 3;
        self.emptyButton.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_RED), for: .normal);
        self.emptyButton.setTitleColor(COLOR_WHITE, for: .normal);
        self.emptyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.emptyButton.setTitle("掏空奖池", for: .normal);
        self.addSubview(self.emptyButton);
        
        self.setData();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData() {
        let text = "投189倍可以掏空奖池9.4亿!";
        var colorChars = ["倍","亿","."];
        for i in 0..<10 {
            colorChars.append(String(i));
        }
        let attString = NSMutableAttributedString(string: text);
        for char in text.characters.enumerated() {
            if (colorChars.contains(String(char.element))) {
                attString.addAttribute(NSForegroundColorAttributeName, value: COLOR_RED, range: NSMakeRange(char.offset,1));
            }
        }
        self.descriptionLabel.attributedText = attString;
        
    }


}
