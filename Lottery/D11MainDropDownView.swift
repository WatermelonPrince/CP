//
//  D11MainDropDownView.swift
//  Lottery
//
//  Created by DTY on 17/2/23.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class D11MainDropDownView: LotteryMainBaseDropDownView {

    override init(frame: CGRect, gameNameArray: Array<String>) {
        super.init(frame: frame, gameNameArray: gameNameArray);
        
        //背景
        let backgroundViewHeight = 15*CGFloat(gameNameArray.count/3+2)+35*CGFloat(gameNameArray.count/3+2);
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: backgroundViewHeight));
        backgroundView.backgroundColor = COLOR_GROUND;
        self.addSubview(backgroundView);
        
        //border
        let borderView = UIView(frame: CGRect(x: 0, y: backgroundView.frame.height, width: self.frame.width, height: 1.5));
        borderView.backgroundColor = COLOR_RED;
        self.addSubview(borderView);
        
        //按钮
        let buttonWidth = self.frame.width*0.3;
        let marginWidth = (self.frame.width-buttonWidth*3)/4
        for name in self.gameNameArray.enumerated() {
            let i = name.offset
            
            //分类
            if (i == 0 || i == 12) {
                
                let separatorLine = UIView(frame: CGRect(x: marginWidth, y: 15*CGFloat(i/3+1)+35*CGFloat(i/3)+CGFloat(12), width: self.frame.width-marginWidth*2, height: 0.5));
                separatorLine.backgroundColor = COLOR_BORDER;
                
                if (i == 12) {
                    separatorLine.frame.origin.y += CGFloat(35);
                }
                
                let typeLabel = UILabel(frame: CGRect(x: self.frame.width/2-60/2, y: separatorLine.frame.minY - 35/2, width: 60, height: 35));
                typeLabel.backgroundColor = backgroundView.backgroundColor;
                typeLabel.textColor = COLOR_FONT_TEXT;
                typeLabel.textAlignment = .center;
                typeLabel.font = UIFont.systemFont(ofSize: 16);
                
                if (i == 0) {
                    typeLabel.text = "普通";
                } else {
                    typeLabel.text = "胆拖";
                }
                
                self.addSubview(separatorLine);
                self.addSubview(typeLabel);
            }
            
            let button = LotteryMainBaseDropDownViewSelectionButton(frame:CGRect(x: marginWidth*CGFloat(i%3+1) + buttonWidth*CGFloat(i%3), y: 15*CGFloat(i/3+1)+35*(CGFloat(i/3)+1), width: buttonWidth, height: 35));
            if (i > 11) {
                button.frame.origin.y += 35;
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
