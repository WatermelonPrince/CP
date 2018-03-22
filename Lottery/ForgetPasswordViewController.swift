//
//  ForgetPasswordViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/27.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: MobileRegisterBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "找回密码";
        self.smsType = SmsService.TYPE_RESETPASSWD;
        
        self.passwordView.label.text = "新密码：";
        self.passwordView.textField.placeholder = "请输入6-16位新密码";
        self.actionButton.setTitle("提交", for: .normal);
        self.actionButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else if (self.passwordView.textField.text == ""){
            ViewUtil.showToast(text: "请输入新密码");
        } else if (self.verifyView.textField.text == ""){
            ViewUtil.showToast(text: "请输入验证码");
        } else {
            self.userService.forgetPassword(mobile: self.mobileView.textField.text!, password: self.passwordView.textField.text!, smsCode: self.verifyView.textField.text!);
        }
    }
    
    override func onCompleteSuccess(service: BaseService) {
        _ = self.navigationController?.popViewController(animated: true);
    }

}
