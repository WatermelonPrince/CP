//
//  VoiceVerifyButton.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class VoiceVerifyButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.setTitle("收不到验证码？试试语音验证码", for: .normal);
        self.setTitleColor(COLOR_BLUE, for: .normal);
        self.setTitleColor(COLOR_FONT_SECONDARY, for: .highlighted);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
