//
//  LotteryBaseTextFieldView.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryBaseTextFieldView: UIView, UITextFieldDelegate{
    var label: UILabel!;
    var textField: LotteryBaseTextField!;
    static let baseHeight: CGFloat = 50;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        //Label
        self.label = UILabel(frame: CGRect(x: 0, y: 0, width: 16*6, height: self.frame.height));
        self.label.font = UIFont.systemFont(ofSize: 14);
        self.label.textColor = COLOR_FONT_TEXT;
        self.label.textAlignment = .right;
        self.addSubview(self.label);
        
        //TextField
        self.textField = LotteryBaseTextField(frame: CGRect(x: self.label.frame.maxX+2, y: self.label.frame.minY, width: self.frame.width-self.label.frame.width-20, height: self.label.frame.height));
        self.textField.font = UIFont.boldSystemFont(ofSize: 15);
        self.textField.returnKeyType = .done;
        self.textField.clearButtonMode = .whileEditing;
        self.addSubview(self.textField);
        self.textField.delegate = self;
        self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as! LotteryBaseTextField).resetTipColor();
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        (textField as! LotteryBaseTextField).resetTipColor();
    }

}
