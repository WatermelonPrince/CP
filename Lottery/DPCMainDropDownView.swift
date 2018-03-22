//
//  DPCMainDropDownView.swift
//  Lottery
//
//  Created by DTY on 17/2/14.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class DPCMainDropDownView: LotteryMainBaseDropDownView {

    override init(frame: CGRect, gameNameArray: Array<String>) {
        super.init(frame: frame, gameNameArray: gameNameArray);
                
        //背景
        let backgroundViewHeight = CGFloat(35 + 15*2);
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: backgroundViewHeight));
        backgroundView.backgroundColor = COLOR_GROUND;
        self.addSubview(backgroundView);
        
        //border
        let borderView = UIView(frame: CGRect(x: 0, y: backgroundView.frame.height, width: self.frame.width, height: 1.5));
        borderView.backgroundColor = COLOR_RED;
        self.addSubview(borderView);
        
        //按钮
        let buttonWidth = self.frame.width*0.3;
        for name in self.gameNameArray.enumerated() {
            
            let button = LotteryMainBaseDropDownViewSelectionButton(frame: CGRect(x: self.frame.width/2-buttonWidth-10, y: 15, width: buttonWidth, height: 35));
            if (name.offset == 1) {
                button.frame.origin.x = self.frame.width/2+10
            }
            button.tag = name.offset;
            button.setTitle(name.element, for: .normal);
            self.addSubview(button);
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside);
            self.buttonArray.append(button);
        }
        
        self.buttonArray[0].sendActions(for: .touchUpInside);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
