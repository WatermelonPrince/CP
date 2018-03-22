//
//  OrderItemTableFooterView.swift
//  Lottery
//
//  Created by DTY on 17/2/3.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderItemTableFooterView: UIView {
    var ruleLabel: LotteryBaseAttributedLabel!;
    var checkBoxImageView: UIImageView!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_GROUND;
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: SCREEN_HEIGHT*2));
        backgroundView.backgroundColor = COLOR_GROUND;
        self.addSubview(backgroundView);
        
        //RuleLabel
        self.ruleLabel = LotteryBaseAttributedLabel(frame: CGRect(x: 0, y: 20, width: 0, height: 0));
        self.ruleLabel.font = UIFont.systemFont(ofSize: 14);
        self.ruleLabel.textColor = COLOR_BORDER;
        self.ruleLabel.setLinkTextColor(color: COLOR_BORDER);
        self.ruleLabel.setActiveLinkTextColor(color: COLOR_FONT_SECONDARY);
        let labelText = "我已阅读并同意《委托投注规则》";
        self.ruleLabel.text = labelText;
        let range = NSString(string: labelText).range(of: "《委托投注规则》");
        self.ruleLabel.addLink(to: CommonUtil.getURL(HTTPConstants.AGREEMENT), with: range);
        self.ruleLabel.sizeToFit();
        self.ruleLabel.center.x = self.center.x + 10;
        self.addSubview(self.ruleLabel);
        
        //CheckBox
        self.checkBoxImageView = UIImageView(frame: CGRect(x: self.ruleLabel.frame.origin.x - 20, y: 0, width: self.ruleLabel.frame.height, height: self.ruleLabel.frame.height));
        self.checkBoxImageView.center.y = self.ruleLabel.center.y;
        self.checkBoxImageView.image = UIImage(named: "icon_order_checkbox");
        self.addSubview(checkBoxImageView);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
