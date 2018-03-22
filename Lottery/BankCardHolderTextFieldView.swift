//
//  BankCardHolderTextFieldView.swift
//  Lottery
//
//  Created by DTY on 2017/5/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class BankCardHolderTextFieldView: BankCardBaseTextFieldView {
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.label.text = "持卡人：";
        self.textField.isUserInteractionEnabled = false;
        
        self.button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonAction() {
        let alertController = UIAlertController(title: "持卡人须与身份验证姓名相同", message: nil, preferredStyle: .alert);
        alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
        alertController.show();
    }

}
