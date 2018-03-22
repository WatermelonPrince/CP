//
//  OrderItemTableViewCell.swift
//  Lottery
//
//  Created by DTY on 17/1/24.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
let LABEL_HEIGHT = 290;

class OrderItemTableViewCell: LotteryBaseTableViewCell {
    var deleteButton: UIButton!;
    var ballNumberLabel: UILabel!;
    var detailNumberLabel: UILabel!;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        self.accessoryType = .disclosureIndicator;
        
        self.deleteButton = UIButton(frame: CGRect(x: 10, y: 0, width: 20, height: 20));
        self.deleteButton.setImage(UIImage(named: "icon_order_delete"), for: .normal);
        self.contentView.addSubview(self.deleteButton);
        
        self.ballNumberLabel = UILabel(frame: CGRect(x: self.deleteButton.frame.maxX+15, y: 10, width: 0, height: 0));
        self.ballNumberLabel.font = UIFont.boldSystemFont(ofSize: 18);
        self.ballNumberLabel.textColor = COLOR_RED;
        self.ballNumberLabel.lineBreakMode = .byWordWrapping;
        self.ballNumberLabel.numberOfLines = 0;
        self.contentView.addSubview(self.ballNumberLabel);
        
        self.detailNumberLabel = UILabel(frame: CGRect(x: self.ballNumberLabel.frame.minX, y: 0, width: self.frame.width-90, height: 15));
        self.detailNumberLabel.font = UIFont.systemFont(ofSize: 14);
        self.detailNumberLabel.textColor = COLOR_FONT_TEXT;
        self.detailNumberLabel.highlightedTextColor = UIColor.brown;
        self.contentView.addSubview(self.detailNumberLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(ballNumberString: String, detailString: String) {
        self.ballNumberLabel.attributedText = CommonUtil.toBallAttributedString(string: ballNumberString);
        let ballNumberLabelWidth = SCREEN_WIDTH-120;
        self.ballNumberLabel.frame.size = CGSize(width: ballNumberLabelWidth, height: CommonUtil.getLabelHeight(text: ballNumberString, width: ballNumberLabelWidth, font: self.ballNumberLabel.font));
        self.detailNumberLabel.text = detailString;
        self.detailNumberLabel.frame.origin.y = self.ballNumberLabel.frame.maxY+8;
        self.deleteButton.center.y = self.contentView.center.y;
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.detailNumberLabel.isHighlighted = highlighted;
    }

}
