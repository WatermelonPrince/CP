//
//  LotteryBaseTextField.swift
//  Lottery
//
//  Created by DTY on 2017/4/26.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textColor = COLOR_FONT_TEXT;
        self.tintColor = COLOR_BLUE;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showTipColor() {
        self.setPlaceholderColor(color: CommonUtil.colorWithAlpha(color: COLOR_RED, alpha: 0.6));
    }
    
    func resetTipColor() {
        let color = UIColor(colorLiteralRed: 0, green: 0, blue: 0.0980392, alpha: 0.22);
        self.setPlaceholderColor(color: color);
    }
    
    func setPlaceholderColor(color: UIColor) {
        if (self.placeholder != nil) {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName : color]);
        }
    }

}
