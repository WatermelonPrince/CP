//
//  HomeTableViewCell.swift
//  Lottery
//
//  Created by DTY on 17/1/18.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class HomeTableViewCell: LotteryBaseTableViewCell {
    
    let kWidth = SCREEN_WIDTH/2
    let kHeight = SCREEN_WIDTH/4;
    var leftItemView: HomeCellItemView!;
    var rightItemView: HomeCellItemView!;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        
        //左右Item
        self.leftItemView = HomeCellItemView(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight));
        self.contentView.addSubview(self.leftItemView);
        self.rightItemView = HomeCellItemView(frame: CGRect(x: kWidth, y: 0, width: kWidth, height: kHeight));
        self.contentView.addSubview(self.rightItemView);
        
        //竖线
        let veriticalLine = UIView(frame: CGRect(x: self.leftItemView.frame.width-1, y: self.leftItemView.frame.minY+kHeight/4, width: DIMEN_BORDER, height: kHeight/2));
        veriticalLine.backgroundColor = COLOR_BORDER;
        self.contentView.addSubview(veriticalLine);
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
