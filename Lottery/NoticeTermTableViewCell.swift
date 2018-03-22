//
//  NoticeTermTableViewCell.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class NoticeTermTableViewCell: LotteryBaseTableViewCell {

    var termInfoLabel: UILabel!;
    var noticeBallListView: NoticeBallListView!;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
//        self.accessoryType = .disclosureIndicator;
        
        self.termInfoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH - 20, height: 20));
        self.termInfoLabel.textColor = COLOR_FONT_TEXT;
        self.termInfoLabel.font = UIFont.systemFont(ofSize: 13);
        self.contentView.addSubview(self.termInfoLabel);
        
        self.noticeBallListView = NoticeBallListView(frame: CGRect(x: self.termInfoLabel.frame.minX, y: self.termInfoLabel.frame.maxY + 20, width: SCREEN_WIDTH - self.termInfoLabel.frame.minX, height: BALL_WIDTH));
        self.contentView.addSubview(self.noticeBallListView);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(isFirst: Bool, awardInfo: AwardInfo) {
        //termInfoLabel
        self.termInfoLabel.text = awardInfo.awardTime;
        
        //ResultBall
        self.noticeBallListView.setData(ballString: awardInfo.winningNumbers!, isFirst: isFirst);

    }

}
