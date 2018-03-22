//
//  MineTableViewCell.swift
//  Lottery
//
//  Created by DTY on 17/3/31.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineTableViewCell: LotteryBaseTableViewCell {
    var monthLabel: UILabel!;
    var dayLabel: UILabel!;
    var lotteryNameLabel: UILabel!;
    var orderInfoLabel: UILabel!;
    var prizeInfoLabel: UILabel!;
    var medalImageView: UIImageView!;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.backgroundColor = COLOR_WHITE;
        self.accessoryType = .disclosureIndicator;
        
        //MonthDay
        self.monthLabel = UILabel(frame: CGRect(x: 5, y: 10, width: 50, height: 20));
        self.monthLabel.font = UIFont.systemFont(ofSize: 13);
        self.monthLabel.textColor = COLOR_FONT_TEXT;
        self.monthLabel.textAlignment = .center;
        self.addSubview(self.monthLabel);
        
        self.dayLabel = UILabel(frame: CGRect(x: self.monthLabel.frame.minX, y: self.monthLabel.frame.maxY, width: self.monthLabel.frame.width, height: self.monthLabel.frame.height));
        self.dayLabel.font = UIFont.boldSystemFont(ofSize: 20);
        self.dayLabel.textColor = COLOR_FONT_TEXT;
        self.dayLabel.textAlignment = .center;
        self.addSubview(self.dayLabel);
        
        //WhiteGround
        
        //LotteryName
        self.lotteryNameLabel = UILabel(frame: CGRect(x: self.monthLabel.frame.maxX, y: self.monthLabel.frame.minY, width: 150, height: self.monthLabel.frame.height));
        self.lotteryNameLabel.font = UIFont.systemFont(ofSize: 16);
        self.lotteryNameLabel.textColor = COLOR_FONT_TEXT;
        self.addSubview(self.lotteryNameLabel);
        
        //OrderInfo
        self.orderInfoLabel = UILabel(frame: CGRect(x: self.lotteryNameLabel.frame.minX, y: self.lotteryNameLabel.frame.maxY, width: self.lotteryNameLabel.frame.width, height: self.lotteryNameLabel.frame.height));
        self.orderInfoLabel.font = UIFont.systemFont(ofSize: 12);
        self.orderInfoLabel.textColor = COLOR_FONT_SECONDARY;
        self.addSubview(self.orderInfoLabel);
        
        //PrizeInfo
        self.prizeInfoLabel = UILabel(frame: CGRect(x: SCREEN_WIDTH-200-40, y: 5, width: 200, height: 45));
        self.prizeInfoLabel.textAlignment = .right;
        self.addSubview(self.prizeInfoLabel);
    
        let imageViewWidth: CGFloat = 71*0.3;
        let imageViewHeight: CGFloat = 137*0.3;
        
        //ModalImage
        self.medalImageView = UIImageView(frame: CGRect(x: SCREEN_WIDTH-imageViewWidth-10, y: 0, width: imageViewWidth, height: imageViewHeight));
        self.medalImageView.image = UIImage(named: "icon_medal");
        self.addSubview(self.medalImageView);
        self.medalImageView.isHidden = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(order: Order) {
        let dateArray = LotteryUtil.orderListDateArray(content: order.createTime!);
        self.monthLabel.text = dateArray[0];
        self.dayLabel.text = dateArray[1];
        
        self.lotteryNameLabel.text = "双色球";
        self.lotteryNameLabel.text = order.gameName;
        self.orderInfoLabel.text = CommonUtil.formatDoubleString(double: Double(order.orderAmount!)) + "元 " + order.orderTypeCn!;
        
        self.prizeInfoLabel.textColor = COLOR_FONT_TEXT;
        self.prizeInfoLabel.font = UIFont.systemFont(ofSize: 15);
        
        self.prizeInfoLabel.text = order.orderStatusCn;
        
        if (order.statusCnColor == "gray") {
            self.prizeInfoLabel.textColor = COLOR_FONT_SECONDARY;
        } else if (order.statusCnColor == "red") {
            self.prizeInfoLabel.textColor = COLOR_RED;
            self.prizeInfoLabel.font = UIFont.boldSystemFont(ofSize: 16);
        } else if (order.statusCnColor == "black") {
            self.prizeInfoLabel.textColor = COLOR_FONT_TEXT;
            self.prizeInfoLabel.font = UIFont.boldSystemFont(ofSize: 15);
        }
        
        if (order.prizeStatus == 2 || order.prizeStatus == 3 || order.prizeStatus == 4) {
            self.medalImageView.isHidden = false;
        } else {
            self.medalImageView.isHidden = true;
        }
        
    }

}
