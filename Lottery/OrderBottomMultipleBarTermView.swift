//
//  OrderBottomMultipleBarTermView.swift
//  Lottery
//
//  Created by DTY on 17/2/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderBottomMultipleBarBaseButton: UIButton {
    var mainLabel: UILabel!;
    var subLabel: UILabel!;
    var checkedImageView: UIImageView!;
    var textInt = 0;
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                self.mainLabel.textColor = COLOR_RED;
                if (subLabel != nil) {
                    self.subLabel.textColor = COLOR_RED;
                }
                self.checkedImageView.isHidden = false;
            } else {
                self.mainLabel.textColor = COLOR_FONT_TEXT;
                if (subLabel != nil) {
                    self.subLabel.textColor = COLOR_FONT_TEXT;
                }
                self.checkedImageView.isHidden = true;
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                self.mainLabel.textColor = COLOR_RED;
                if (subLabel != nil) {
                    self.subLabel.textColor = COLOR_RED;
                }
            } else {
                self.mainLabel.textColor = COLOR_FONT_TEXT;
                if (subLabel != nil) {
                    self.subLabel.textColor = COLOR_FONT_TEXT;
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_WHITE), for: .normal);
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.layer.borderWidth = 0.5;
        
        self.checkedImageView = UIImageView(frame: CGRect(x: self.frame.width - self.frame.height/2, y: self.frame.height/2, width: self.frame.height/2, height: self.frame.height/2));
        self.checkedImageView.image = UIImage(named: "icon_button_checked");
        self.addSubview(self.checkedImageView);
        self.checkedImageView.isHidden = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OrderBottomMultipleBarTermView: UIView {
    var leftButton: OrderBottomMultipleBarBaseButton!;
    var middleButton: OrderBottomMultipleBarBaseButton!;
    var rightButton: OrderBottomMultipleBarBaseButton!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_BORDER;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
