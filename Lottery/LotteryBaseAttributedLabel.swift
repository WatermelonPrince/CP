//
//  LotteryBaseAttributedLabel.swift
//  Lottery
//
//  Created by DTY on 2017/4/14.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseAttributedLabel: TTTAttributedLabel, TTTAttributedLabelDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.delegate = self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLinkTextColor(color: UIColor) {
        self.linkAttributes = [NSForegroundColorAttributeName : color, NSUnderlineColorAttributeName : NSUnderlineStyle.styleSingle];
    }
    
    func setActiveLinkTextColor(color: UIColor) {
        self.activeLinkAttributes = [NSForegroundColorAttributeName : color];
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        let vc = CommonUtil.findViewController(view: self);
        LotteryRoutes.routeURLString(url.absoluteString, withParameters: [routeViewControllerKey : vc]);
    }

}
