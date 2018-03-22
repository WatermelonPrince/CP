//
//  OrderBottomMultipleBarMainView.swift
//  Lottery
//
//  Created by DTY on 17/2/6.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class OrderBottomMultipleBarBaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.textColor = COLOR_FONT_TEXT;
        self.font = UIFont.systemFont(ofSize: 16);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class OrderBottomMultipleBarBaseTextField: LotteryBaseTextField, APNumberPadDelegate, UITextFieldDelegate {
    var maxInt = 1;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.clipsToBounds = true
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 2;
        self.textColor = COLOR_FONT_TEXT;
        self.textAlignment = .center;
        self.keyboardType = .numberPad;
        let numberPad = APNumberPad(delegate: self);
        numberPad.leftFunctionButton.setTitle("确定", for: .normal);
        self.inputView = numberPad;
        self.text = "1";
        self.delegate = self;
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(self);
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text! == "" || Int(textField.text!)! == 0) {
           ViewUtil.showToast(text: "最小输入1");
            textField.text = "1";
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        if (textField.text != "") {
            if (Int(textField.text!)! > self.maxInt) {
                ViewUtil.showToast(text: "最大输入\(self.maxInt)");
                textField.text = "\(self.maxInt)";
            }
        }

    }
    
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder) {
        self.resignFirstResponder();
    }

}

class OrderBottomMultipleBarMainView: UIView {
    var termTextField: OrderBottomMultipleBarBaseTextField!;
    var multipleTextField: OrderBottomMultipleBarBaseTextField!;
    var addNumberButton: LotteryCheckBoxButton!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = COLOR_WHITE;
        self.layer.borderColor = COLOR_BORDER.cgColor;
        self.layer.borderWidth = 0.5;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
