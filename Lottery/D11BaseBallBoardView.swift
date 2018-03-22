//
//  D11BaseBallBoardView.swift
//  Lottery
//
//  Created by DTY on 17/3/29.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11MissLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textColor = COLOR_BORDER;
        self.font = UIFont.systemFont(ofSize: self.frame.width*0.35);
        self.textAlignment = .center;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class D11SelectAllButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.setBackgroundImage(CommonUtil.creatImageWithColor(color: COLOR_WHITE), for: .normal);
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.layer.cornerRadius = 3;
        self.setTitleColor(UIColor.brown, for: .normal);
        self.titleLabel?.font = UIFont.systemFont(ofSize: self.frame.width*0.35);
        self.setTitle("全选", for: .normal);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class D11BaseBallBoardView: LotteryBaseBallBoardView {
    var selectPointLabel: LotteryTrianglePointView!;
    var missPointLabel: LotteryTrianglePointView!;
    var selectAllButton: UIButton!;
    
    var missLabelArray = Array<D11MissLabel>();

}
