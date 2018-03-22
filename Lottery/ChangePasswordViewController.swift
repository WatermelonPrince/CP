//
//  ChangePasswordViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ChangePasswordViewController: LotteryBaseScrollViewController,ServiceDelegate {
    
    var passwordView: PasswordTextFieldView!;
    var submitButton: LotteryBaseButton!;
    
    var userService: UserService!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改登录密码";

        //密码
        self.passwordView = PasswordTextFieldView(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: LotteryBaseTextFieldView.baseHeight));
        self.passwordView.label.text = "新密码：";
        self.passwordView.textField.placeholder = "请输入6-16位新密码";
        self.scrollView.addSubview(self.passwordView);
        
        //登陆
        self.submitButton = LotteryBaseButton(frame: CGRect(x: 20, y: self.passwordView.frame.maxY + 20, width: self.view.frame.width-20*2, height: self.passwordView.frame.height));
        self.submitButton.setTitle("提交", for: .normal);
        self.scrollView.addSubview(self.submitButton);
        self.submitButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside);
        
        self.userService = UserService(delegate: self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCompleteSuccess(service: BaseService) {
        self.navigationController?.popToRootViewController(animated: true);
    }
    
    func submitAction() {
        if (self.passwordView.textField.text == ""){
            ViewUtil.showToast(text: "请输入新密码");
        } else {
            self.userService.changePassword(password: self.passwordView.textField.text!);
        }
    }

}
