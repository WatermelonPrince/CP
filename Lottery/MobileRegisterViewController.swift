//
//  MobileRegisterViewController.swift
//  Lottery
//
//  Created by DTY on 17/3/30.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MobileRegisterBasicViewController: LotteryBaseScrollViewController, ServiceDelegate {
    var mobileView: MobileTextFieldView!;
    var passwordView: PasswordTextFieldView!;
    var verifyView: VerifyTextFieldView!;
    var voiceVerifyButton: VoiceVerifyButton!;
    var actionButton: LotteryBaseButton!;
    var userService: UserService!;
    var smsService: SmsService!;
    var smsType = SmsService.TYPE_REGISTER;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLOR_GROUND;
        //手机号
        self.mobileView = MobileTextFieldView(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: LotteryBaseTextFieldView.baseHeight));
        self.scrollView.addSubview(self.mobileView);
        
        //密码
        self.passwordView = NewPasswordTextFieldView(frame: CGRect(x: 0, y: self.mobileView.frame.maxY + 1, width: self.view.frame.width, height: self.mobileView.frame.height));
        self.scrollView.addSubview(self.passwordView);
        
        //验证码
        self.verifyView = VerifyTextFieldView(frame: CGRect(x: 0, y: self.passwordView.frame.maxY + 1, width: self.view.frame.width, height: self.passwordView.frame.height));
        self.scrollView.addSubview(self.verifyView);
        self.verifyView.button.addTarget(self, action: #selector(verifyAction), for: .touchUpInside);
        
        //语音验证码
        self.voiceVerifyButton = VoiceVerifyButton(frame: CGRect(x: self.view.frame.width - 200 - 20, y: self.verifyView.frame.maxY + 10, width: 200, height: 16));
        self.scrollView.addSubview(self.voiceVerifyButton);
        self.voiceVerifyButton.addTarget(self, action: #selector(voiceVerifyAction), for: .touchUpInside);
        
        //注册
        self.actionButton = LotteryBaseButton(frame: CGRect(x: 20, y: self.voiceVerifyButton.frame.maxY + 20, width: self.view.frame.width-20*2, height: self.mobileView.frame.height));
        self.actionButton.setTitle("注册", for: .normal);
        self.scrollView.addSubview(self.actionButton);
        
        //Service
        self.smsService = SmsService(delegate: self);
        self.userService = UserService(delegate: self);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCompleteSuccess(service: BaseService) {
        
    }
    
    func onCompleteFail(service: BaseService) {
        VerifyTextFieldView.verifyTimeInt = 1;
    }
    
    func verifyAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else {
            self.verifyView.createVerifyTimer();
            self.smsService.sendSms(mobile: self.mobileView.textField.text!, type: self.smsType);
        }
    }
    
    func voiceVerifyAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else {
            self.smsService.sendVoiceSms(mobile: self.mobileView.textField.text!, type: self.smsType);
        }
    }

}


class MobileRegisterViewController: MobileRegisterBasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "手机号注册";
        
        self.smsType = SmsService.TYPE_REGISTER;
        
        self.actionButton.setTitle("注册", for: .normal);
        self.actionButton.addTarget(self, action: #selector(registerAction), for: .touchUpInside);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else if (self.passwordView.textField.text == ""){
            ViewUtil.showToast(text: "请输入密码");
        } else if (self.verifyView.textField.text == ""){
            ViewUtil.showToast(text: "请输入验证码");
        } else {
            self.userService.register(mobile: self.mobileView.textField.text!, password: self.passwordView.textField.text!, smsCode: self.verifyView.textField.text!, from: nil);
            self.mobileView.textField.resignFirstResponder();
            self.passwordView.textField.resignFirstResponder();
            self.verifyView.textField.resignFirstResponder();
        }
    }
    
    override func onCompleteSuccess(service: BaseService) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName), object: self, userInfo: nil));
        self.dismiss(animated: true, completion: nil);
        LotteryUtil.saveIsWechatLogin(isWechatLogin: false);
    }

}
