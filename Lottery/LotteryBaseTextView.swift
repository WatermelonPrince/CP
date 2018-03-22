//
//  LotteryBaseTextView.swift
//  Lottery
//
//  Created by DTY on 2017/4/26.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseTextView: KMPlaceholderTextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer);
        self.tintColor = COLOR_BLUE;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
