//
//  MineOrderDetailTableHeaderView.swift
//  Lottery
//
//  Created by DTY on 2017/4/1.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineOrderDetailTableHeaderView: UIView {
    let kHeight: CGFloat = 20;
    
    var lotteryImageView: UIImageView!;
    var lotteryNameTermLabel: UILabel!;
    var orderAmountNumberLabel: UILabel!;
    var prizeAmountNumberLabel: UILabel!;
    var rightImageView: UIImageView!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        //图
        self.lotteryImageView = UIImageView(frame: CGRect(x: 15, y: 15, width: 40, height: 40));
        self.addSubview(self.lotteryImageView);
        
        //彩种名称期数
        self.lotteryNameTermLabel = UILabel(frame: CGRect(x: self.lotteryImageView.frame.maxX + 10, y: self.lotteryImageView.frame.minY + 10, width: self.frame.width/2, height: kHeight));
        self.lotteryNameTermLabel.textColor = COLOR_FONT_TEXT;
        self.addSubview(self.lotteryNameTermLabel);
        
        //订单金额数
        self.orderAmountNumberLabel = UILabel(frame: CGRect(x: self.lotteryImageView.frame.minX, y: self.lotteryImageView.frame.maxY + 10, width: 120, height: 30));
        self.orderAmountNumberLabel.textColor = COLOR_FONT_SECONDARY;
        self.addSubview(self.orderAmountNumberLabel);
        
        //订单金额
        let orderAmountLabel = UILabel(frame: CGRect(x: self.lotteryImageView.frame.minX, y: self.orderAmountNumberLabel.frame.maxY, width: self.orderAmountNumberLabel.frame.width, height: kHeight));
        orderAmountLabel.font = UIFont.systemFont(ofSize: 13);
        orderAmountLabel.textColor = COLOR_FONT_SECONDARY;
        self.addSubview(orderAmountLabel);
        orderAmountLabel.text = "订单金额";
        
        //中奖金额数
        self.prizeAmountNumberLabel = UILabel(frame: CGRect(x: orderAmountLabel.frame.maxX, y: self.orderAmountNumberLabel.frame.minY, width: SCREEN_WIDTH-self.orderAmountNumberLabel.frame.maxX, height: 30));
        self.prizeAmountNumberLabel.font = UIFont.boldSystemFont(ofSize: 17);
        self.prizeAmountNumberLabel.textColor = COLOR_FONT_SECONDARY;
        self.addSubview(self.prizeAmountNumberLabel);
        self.prizeAmountNumberLabel.text = "--";
        
        //中奖金额
        let prizeAmountLabel = UILabel(frame: CGRect(x: self.orderAmountNumberLabel.frame.maxX, y: orderAmountLabel.frame.minY, width: self.prizeAmountNumberLabel.frame.width, height: kHeight));
        prizeAmountLabel.font = UIFont.systemFont(ofSize: 13);
        prizeAmountLabel.textColor = COLOR_FONT_SECONDARY;
        self.addSubview(prizeAmountLabel);
        prizeAmountLabel.text = "中奖金额";
        
        //右侧图片
        let rightImageHeight = self.lotteryImageView.frame.height;
        let rightImageWidth = rightImageHeight * 282/183;
        self.rightImageView = UIImageView(frame: CGRect(x: self.frame.width-rightImageWidth, y: self.lotteryImageView.frame.minY, width: rightImageWidth, height: rightImageHeight));
        self.addSubview(self.rightImageView);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(orderDetail: OrderDetail) {
        //图
        self.lotteryImageView.sd_setImage(with: CommonUtil.getURL(orderDetail.gameImageUrl));
        
        //彩种名称期数
        let nameAttString = NSMutableAttributedString(string: "\(orderDetail.gameName!) ", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)]);
        let termAttString = NSMutableAttributedString(string: "\(orderDetail.periodId!)期", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]);
        let lotteryNameTermAttString = NSMutableAttributedString();
        lotteryNameTermAttString.append(nameAttString);
        lotteryNameTermAttString.append(termAttString);
        self.lotteryNameTermLabel.attributedText = lotteryNameTermAttString;
        
        //订单金额数
        let orderAmountAttString = NSMutableAttributedString(string: "\(CommonUtil.formatDoubleString(double: orderDetail.orderAmount!))", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]);
        let yuanAttString = NSMutableAttributedString(string: "元", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)]);
        let orderAmountNumberAttString = NSMutableAttributedString();
        orderAmountNumberAttString.append(orderAmountAttString);
        orderAmountNumberAttString.append(yuanAttString);
        self.orderAmountNumberLabel.attributedText = orderAmountNumberAttString;
        
        var isDraw: Bool;
        if (orderDetail.prizeStatus == nil || orderDetail.prizeStatus == 0) {
            isDraw = false;
        } else {
            isDraw = true;
        }
        var amount = orderDetail.bonus;
        if (amount == nil) {
            amount = 0.00
        }
        //中奖金额数
        if (isDraw == true && amount! > 0.00) {
            let prizeAmountAttString = NSMutableAttributedString(string: String(describing: amount!), attributes: [NSForegroundColorAttributeName: COLOR_RED, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 24)]);
            let yuanAttString = NSMutableAttributedString(string: "元", attributes: [NSForegroundColorAttributeName: COLOR_RED, NSFontAttributeName: UIFont.systemFont(ofSize: K_FONT_SIZE*1.3)]);
            let prizeAmountNumberAttString = NSMutableAttributedString();
            prizeAmountNumberAttString.append(prizeAmountAttString);
            prizeAmountNumberAttString.append(yuanAttString);
            self.prizeAmountNumberLabel.attributedText = prizeAmountNumberAttString;
            self.rightImageView.image = #imageLiteral(resourceName: "icon_right_prize");
        } else if (isDraw == true && amount! == 0) {
            self.rightImageView.image = #imageLiteral(resourceName: "icon_right_noprize");
        } else if (isDraw == false) {
            self.rightImageView.image = #imageLiteral(resourceName: "icon_right_wait");
        }
        
    }
    
    func setData(followDetail: FollowDetail) {
        //图
        self.lotteryImageView.sd_setImage(with: CommonUtil.getURL(followDetail.gameImageUrl));
        
        //彩种名称期数
        let nameAttString = NSMutableAttributedString(string: "\(followDetail.gameName!) ", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18)]);
        let termAttString = NSMutableAttributedString(string: "追号共\((followDetail.followOrderVos?.count)!)期", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]);
        let lotteryNameTermAttString = NSMutableAttributedString();
        lotteryNameTermAttString.append(nameAttString);
        lotteryNameTermAttString.append(termAttString);
        self.lotteryNameTermLabel.attributedText = lotteryNameTermAttString;
        
        //订单金额数
        let orderAmountAttString = NSMutableAttributedString(string: "\(CommonUtil.formatDoubleString(double: followDetail.amount!))", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17)]);
        let yuanAttString = NSMutableAttributedString(string: "元", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)]);
        let orderAmountNumberAttString = NSMutableAttributedString();
        orderAmountNumberAttString.append(orderAmountAttString);
        orderAmountNumberAttString.append(yuanAttString);
        self.orderAmountNumberLabel.attributedText = orderAmountNumberAttString;
        
        var isDraw: Bool;
        if (followDetail.prizeStatus == nil || followDetail.prizeStatus == 0) {
            isDraw = false;
        } else {
            isDraw = true;
        }
        var amount = followDetail.bonus;
        if (amount == nil) {
            amount = 0.00;
        }
        //中奖金额数
        if (isDraw == true && amount! > 0.00) {
            let prizeAmountAttString = NSMutableAttributedString(string: String(describing: amount!), attributes: [NSForegroundColorAttributeName: COLOR_RED, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 24)]);
            let yuanAttString = NSMutableAttributedString(string: "元", attributes: [NSForegroundColorAttributeName: COLOR_RED, NSFontAttributeName: UIFont.systemFont(ofSize: K_FONT_SIZE*1.3)]);
            let prizeAmountNumberAttString = NSMutableAttributedString();
            prizeAmountNumberAttString.append(prizeAmountAttString);
            prizeAmountNumberAttString.append(yuanAttString);
            self.prizeAmountNumberLabel.attributedText = prizeAmountNumberAttString;
            self.rightImageView.image = #imageLiteral(resourceName: "icon_right_prize");
        } else if (isDraw == true && amount! == 0) {
            self.rightImageView.image = #imageLiteral(resourceName: "icon_right_noprize");
        } else if (isDraw == false) {
            self.rightImageView.image = #imageLiteral(resourceName: "icon_right_wait");
        }
        
    }

    
}
