//
//  OrderTopButtonsView.swift
//  Lottery
//
//  Created by DTY on 17/2/3.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderTopBaseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.layer.borderWidth = 0.5;
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_WHITE), for: .normal);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        self.setTitleColor(COLOR_FONT_TEXT, for: .normal);
        self.imageView?.frame.size = CGSize(width: 20, height: 20);
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5);
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class OrderTopButtonsView: UIView {
    
    var selfSelectionButton: UIButton!;
    var machineSelectionButton: UIButton!;
    var clearListButton: UIButton!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.selfSelectionButton = OrderTopBaseButton(frame: CGRect(x: 15, y: 0, width: (self.frame.width-15*4)/3, height: 30));
        selfSelectionButton.setTitle("自选号码", for: .normal);
        selfSelectionButton.setImage(UIImage(named: "icon_order_plus"), for: .normal);
        self.addSubview(self.selfSelectionButton);
        
        self.machineSelectionButton = OrderTopBaseButton(frame: CGRect(x: self.selfSelectionButton.frame.maxX+15, y: self.selfSelectionButton.frame.minY, width: self.selfSelectionButton.frame.width, height: self.selfSelectionButton.frame.height));
        machineSelectionButton.setTitle("机选一注", for: .normal);
        machineSelectionButton.setImage(UIImage(named: "icon_order_plus"), for: .normal);
        self.addSubview(self.machineSelectionButton);
        
        self.clearListButton = OrderTopBaseButton(frame: CGRect(x: self.machineSelectionButton.frame.maxX+15, y: self.selfSelectionButton.frame.minY, width: self.selfSelectionButton.frame.width, height: self.selfSelectionButton.frame.height));
        clearListButton.setTitle("清空列表", for: .normal);
        clearListButton.setImage(UIImage(named: "icon_order_trash"), for: .normal);
        self.addSubview(self.clearListButton);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
