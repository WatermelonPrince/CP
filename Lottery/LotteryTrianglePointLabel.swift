//
//  LotteryTrianglePointLabel.swift
//  Lottery
//
//  Created by DTY on 17/2/22.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryTrianglePointView: UILabel {
    let fillColor = UIColor(colorLiteralRed: 244/255, green: 242/255, blue: 227/255, alpha: 1);
    let borderColor = UIColor(colorLiteralRed: 236/255, green: 232/255, blue: 218/255, alpha: 1);
    

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textColor = UIColor.brown;
        self.font = UIFont.systemFont(ofSize: self.frame.width*0.3);
        self.textAlignment = .center;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!;
        context.setAllowsAntialiasing(true);
        context.beginPath();
        context.move(to: CGPoint(x: 0, y: 0));
        context.addLine(to: CGPoint(x: rect.width*0.75, y: 0));
        context.addLine(to: CGPoint(x: rect.width-1, y: rect.height*0.5-2));
        context.addLine(to: CGPoint(x: rect.width*0.75, y: rect.height-1));
        context.addLine(to: CGPoint(x: 0, y: rect.height-1));
        context.closePath();
        self.fillColor.setFill();
        self.borderColor.setStroke();
        context.drawPath(using: .fillStroke);
        super.draw(rect);
    }
    
}
