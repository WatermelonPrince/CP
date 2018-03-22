//
//  NoticeTableViewCell.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class NoticeTableViewCell: LotteryBaseTableViewCell {
    
    var lotteryLabel: UILabel!;
    var noticeBallListView: NoticeBallListView!;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.accessoryType = .disclosureIndicator;
        
        self.lotteryLabel = UILabel(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH - 20, height: 20));
        self.lotteryLabel.textColor = COLOR_FONT_TEXT;
        self.contentView.addSubview(self.lotteryLabel);
        
        self.noticeBallListView = NoticeBallListView(frame: CGRect(x: self.lotteryLabel.frame.minX, y: self.lotteryLabel.frame.maxY + 20, width: SCREEN_WIDTH - self.lotteryLabel.frame.minX, height: BALL_WIDTH));
        self.contentView.addSubview(self.noticeBallListView);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(awardInfo: AwardInfo) {
        //LotteryLabel
        let nameContent = NSMutableAttributedString(string: "\(awardInfo.gameName!) ", attributes: [NSForegroundColorAttributeName : COLOR_FONT_TEXT, NSFontAttributeName : UIFont.systemFont(ofSize: 16)]);
        let termInfoContent = NSMutableAttributedString(string: awardInfo.awardTime!, attributes: [NSForegroundColorAttributeName : COLOR_FONT_SECONDARY, NSFontAttributeName : UIFont.systemFont(ofSize: 13)]);
        let attString = NSMutableAttributedString();
        attString.append(nameContent);
        attString.append(termInfoContent);
        self.lotteryLabel.attributedText = attString;
        
        //ResultBall
        self.noticeBallListView.setData(ballString: awardInfo.winningNumbers!, isFirst: true);
    }
}
