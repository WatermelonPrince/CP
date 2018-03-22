//
//  ChargeAmountTableViewCell.swift
//  Lottery
//
//  Created by DTY on 2017/4/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ChargeAmountTextField: LotteryBaseTextField, APNumberPadDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true;
        self.backgroundColor = COLOR_WHITE;
        self.layer.cornerRadius = 3;
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.layer.borderWidth = 0.5;
        self.placeholder = "自定义金额";
        self.textColor = COLOR_RED;
        self.font = UIFont.systemFont(ofSize: 15);
        self.textAlignment = .center;
        self.keyboardType = .numberPad;
        let numberPad = APNumberPad(delegate: self);
        numberPad.leftFunctionButton.setTitle("确定", for: .normal);
        self.inputView = numberPad;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder) {
        self.resignFirstResponder();
    }
    
}

class ChargeAmountTableViewCell: LotteryBaseTableViewCell, UITextFieldDelegate {
    var buttonArray = Array<LotteryBaseSelectionButton>();
    var selectedAmount: Int = 0;
    var textField: ChargeAmountTextField!;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        self.selectionStyle = .none;
        
        let buttonWidth = SCREEN_WIDTH*0.3;
        let marginWidth = (SCREEN_WIDTH-buttonWidth*3)/4
        
        for i in 0..<6 {
            let frame = CGRect(x: marginWidth*CGFloat(i%3+1) + buttonWidth*CGFloat(i%3), y: 15*CGFloat(i/3)+35*(CGFloat(i/3)), width: buttonWidth, height: 35);
            if (i < 5) {
                let button = LotteryBaseSelectionButton(frame:frame);
                var amount = 0;
                if (i == 0) {
                    amount = 50;
                } else if (i == 1) {
                    amount = 100;
                } else if (i == 2) {
                    amount = 200;
                } else if (i == 3) {
                    amount = 300;
                } else if (i == 4) {
                    amount = 500;
                }
                button.setTitle(String(amount), for: .normal);
                self.contentView.addSubview(button);
                button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside);
                button.tag = amount;
                self.buttonArray.append(button);
            } else {
                self.textField = ChargeAmountTextField(frame: frame);
                self.contentView.addSubview(self.textField);
                self.textField.delegate = self;
                self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged);
            }
            
        }
    
        self.buttonArray[1].sendActions(for: .touchUpInside);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonAction(_ button: LotteryBaseSelectionButton) {
        textField.textColor = COLOR_FONT_TEXT;
        textField.layer.borderColor = COLOR_BORDER.cgColor;
        self.textField.resignFirstResponder();
        
        for button in self.buttonArray {
            button.isSelected = false;
        }
        self.selectedAmount = button.tag;
        button.isSelected = true;
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        for button in self.buttonArray {
            button.isSelected = false;
        }
        textField.textColor = COLOR_RED;
        textField.layer.borderColor = COLOR_RED.cgColor;
        if (self.textField.text != "") {
            self.selectedAmount = Int(textField.text!)!;
        }
        
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        let maxInt = 999999;
        if (textField.text != "") {
            if (Int(textField.text!)! == 0) {
                ViewUtil.showToast(text: "最小充值金额为1");
                textField.text = "1";
            }
            
            if (Int(textField.text!)! > maxInt) {
                ViewUtil.showToast(text: "最大充值金额为\(maxInt)");
                textField.text = "\(maxInt)";
            }
        }
        if (textField.text == "") {
            self.selectedAmount = 0;
        } else {
           self.selectedAmount = Int(textField.text!)!;
        }
        
    }

}
