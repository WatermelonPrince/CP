//
//  LotteryCheckBoxButton.swift
//  Lottery
//
//  Created by DTY on 17/2/15.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryCheckBoxButton: UIButton {
    var checkboxImageView: UIImageView!;
    var descriptionLabel: UILabel!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.addTarget(self, action: #selector(checkAction), for: .touchDown);
        
        self.checkboxImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.height, height: self.frame.height));
        self.checkboxImageView.image = UIImage(named: "icon_order_stop_checkbox_unchecked");
        self.addSubview(self.checkboxImageView);
        
        self.descriptionLabel = UILabel(frame: CGRect(x: self.checkboxImageView.frame.maxX + 5, y: self.checkboxImageView.frame.minY, width: self.frame.width-self.checkboxImageView.frame.width-5, height: self.checkboxImageView.frame.height));
        self.descriptionLabel.textColor = COLOR_FONT_TEXT;
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14);
        self.addSubview(self.descriptionLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkAction() {
        self.isSelected = !self.isSelected;
        
        if (self.isSelected) {
            self.checkboxImageView.image = UIImage(named: "icon_order_stop_checkbox_checked");
            self.descriptionLabel.textColor = COLOR_RED;
        } else {
            self.checkboxImageView.image = UIImage(named: "icon_order_stop_checkbox_unchecked");
            self.descriptionLabel.textColor = COLOR_FONT_TEXT;
        }
    }

}
