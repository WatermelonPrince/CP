//
//  LotteryBaseSelectionButton.swift
//  Lottery
//
//  Created by DTY on 2017/4/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseSelectionButton: UIButton {

    var checkedImageView: UIImageView!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.backgroundColor = COLOR_WHITE;
        self.layer.cornerRadius = 3;
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.layer.borderWidth = 0.5;
        self.setTitleColor(COLOR_FONT_TEXT, for: .normal);
        self.setTitleColor(COLOR_RED, for: .highlighted);
        self.setTitleColor(COLOR_RED, for: .selected);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15);
        
        self.checkedImageView = UIImageView(frame: CGRect(x: self.frame.width - self.frame.height/2, y: self.frame.height/2, width: self.frame.height/2, height: self.frame.height/2));
        self.checkedImageView.image = UIImage(named: "icon_button_checked");
        self.addSubview(self.checkedImageView);
        self.checkedImageView.isHidden = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                self.layer.borderColor = COLOR_RED.cgColor;
                self.checkedImageView.isHidden = false;
                self.setTitleColor(COLOR_RED, for: .normal);
            } else {
                if (!isSelected) {
                    self.layer.borderColor = COLOR_BORDER.cgColor;
                    self.checkedImageView.isHidden = true;
                }
                self.setTitleColor(COLOR_FONT_TEXT, for: .normal);
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                self.layer.borderColor = COLOR_RED.cgColor;
                self.checkedImageView.isHidden = false;
            } else {
                self.layer.borderColor = COLOR_BORDER.cgColor;
                self.checkedImageView.isHidden = true;
            }
        }
    }

}
