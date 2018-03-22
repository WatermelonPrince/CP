//
//  LotteryBaseEmptyButton.swift
//  Lottery
//
//  Created by DTY on 2017/4/21.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseEmptyButton: UIButton {
    var emptyImageView: UIImageView!
    var descriptionLabel: UILabel!;
    var descriptionText = "暂无记录";

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.emptyImageView = UIImageView(image: UIImage(named: "icon_empty_common"));
        self.emptyImageView.frame = CGRect(x: self.frame.width*(1/6), y: 0, width: self.frame.width*(2/3), height: self.frame.width*(2/3));
        self.addSubview(self.emptyImageView);
        
        self.descriptionLabel = UILabel(frame: CGRect(x: 0, y: self.frame.width*(2/3), width: self.frame.width, height: self.frame.width*(1/3)));
        self.descriptionLabel.font = UIFont.systemFont(ofSize: self.descriptionLabel.frame.height*0.22);
        self.descriptionLabel.textColor = COLOR_FONT_SECONDARY;
        self.descriptionLabel.textAlignment = .center;
        self.addSubview(self.descriptionLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
