//
//  IdentityVerifyViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/6.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class IdentityVerifyViewController: LotteryBaseScrollViewController, ServiceDelegate {
    var descriptionLabel: UILabel!
    var nameView: LotteryBaseTextFieldView!;
    var idView: LotteryBaseTextFieldView!;
    var mobileView: MobileTextFieldView!;
    var smsView: VerifyTextFieldView!;
    var voiceVerifyButton: VoiceVerifyButton!;
    var actionButton: LotteryBaseButton!;

    var smsService: SmsService!;
    var identityService: IdentityService!;
    
    var hasIdentity = false;
    var shouldNavWithdraw = false;
    var shouldNavBankCard = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "身份验证";
        
        
        //Description
        self.descriptionLabel = UILabel(frame: CGRect(x: 15, y: 0, width: self.view.frame.width-15*2, height: LotteryBaseTextFieldView.baseHeight));
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 15);
        self.descriptionLabel.textColor = COLOR_FONT_SECONDARY;
        self.scrollView.addSubview(self.descriptionLabel);
        descriptionLabel.text = "提现前请先进行身份信息认证";
        self.descriptionLabel.isHidden = self.hasIdentity;
        
        //真实姓名
        self.nameView = LotteryBaseTextFieldView(frame: CGRect(x: 0, y: descriptionLabel.frame.maxY, width: self.view.frame.width, height: LotteryBaseTextFieldView.baseHeight));
        self.nameView.label.text = "真实姓名：";
        self.nameView.textField.placeholder = "须与身份证一致，不可修改";
        self.scrollView.addSubview(self.nameView);
        self.nameView.textField.isEnabled = !self.hasIdentity;
        if (self.hasIdentity) {
            self.nameView.frame.origin.y = 20;
            self.nameView.textField.placeholder = "";
        }
        
        //身份证号
        self.idView = LotteryBaseTextFieldView(frame: CGRect(x: 0, y: self.nameView.frame.maxY + 1, width: self.view.frame.width, height: self.nameView.frame.height));
        self.idView.label.text = "身份证号：";
        self.idView.textField.placeholder = "须与身份证一致，不可修改";
        self.idView.textField.keyboardType = .numbersAndPunctuation;
        self.scrollView.addSubview(self.idView);
        self.idView.textField.isEnabled = !self.hasIdentity;
        if (self.hasIdentity) {
            self.idView.textField.placeholder = "";
        }
        
        //手机号码
        self.mobileView = MobileTextFieldView(frame: CGRect(x: 0, y: self.idView.frame.maxY + 20, width: self.view.frame.width, height: self.nameView.frame.height));
        self.scrollView.addSubview(self.mobileView);
        if (self.hasIdentity) {
            self.mobileView.frame.origin.y = self.idView.frame.maxY + 1;
            self.mobileView.textField.placeholder = "";
        }
        self.mobileView.textField.isEnabled = !self.hasIdentity;
        
        
        //验证码
        self.smsView = VerifyTextFieldView(frame: CGRect(x: 0, y: self.mobileView.frame.maxY + 1, width: self.view.frame.width, height: self.nameView.frame.height));
        self.scrollView.addSubview(self.smsView);
        self.smsView.button.addTarget(self, action: #selector(verifyAction), for: .touchUpInside);
        self.smsView.isHidden = self.hasIdentity;
        
        //语音验证码
        self.voiceVerifyButton = VoiceVerifyButton(frame: CGRect(x: self.view.frame.width - 200 - 20, y: self.smsView.frame.maxY + 10, width: 200, height: 16));
        self.scrollView.addSubview(self.voiceVerifyButton);
        self.voiceVerifyButton.addTarget(self, action: #selector(voiceVerifyAction), for: .touchUpInside);
        self.voiceVerifyButton.isHidden = self.hasIdentity;
        
        //actionButton
        self.actionButton = LotteryBaseButton(frame: CGRect(x: 20, y: self.voiceVerifyButton.frame.maxY + 20, width: self.view.frame.width-20*2, height: self.nameView.frame.height));
        self.actionButton.setTitle("立即验证", for: .normal);
        self.scrollView.addSubview(self.actionButton);
        self.actionButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside);
        self.actionButton.isHidden = self.hasIdentity;
        
        //Service
        self.smsService = SmsService();
        self.identityService = IdentityService(delegate: self);
        
        if (self.hasIdentity) {
            self.identityService.queryIdentity();
            ViewUtil.showProgressToast();
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCompleteSuccess(service: BaseService) {
        if (service == self.identityService) {
            if (self.hasIdentity) {
                ViewUtil.dismissToast();
                self.nameView.textField.text = self.identityService.name;
                self.idView.textField.text = self.identityService.identityCard;
                self.mobileView.textField.text = self.identityService.mobile;
            } else {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName)));
                ViewUtil.showToast(text: "身份认证成功");
                if (self.shouldNavBankCard || self.shouldNavWithdraw) {
                    let vc = BankCardViewController();
                    vc.hasCancelButton = true;
                    vc.shouldNavWithdraw = self.shouldNavWithdraw;
                    self.pushViewController(viewController: vc);
                } else {
                    self.navigationController?.popViewController(animated: true);
                }
            }
        }
    }
    
    func verifyAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else {
            self.smsView.createVerifyTimer();
            self.smsService.sendSms(mobile: self.mobileView.textField.text!);
        }
    }
    
    func voiceVerifyAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的手机号");
        } else {
            //Todo
        }
    }
    
    func submitAction() {
        if (self.nameView.textField.text == "") {
            ViewUtil.showToast(text: "请输入您的真实姓名");
        } else if (self.idView.textField.text == ""){
            ViewUtil.showToast(text: "请输入您的身份证号");
        } else if (self.mobileView.textField.text == ""){
            ViewUtil.showToast(text: "请输入您的手机号");
        } else if (self.smsView.textField.text == ""){
            ViewUtil.showToast(text: "请输入验证码");
        } else {
            ViewUtil.showProgressToast();
            self.identityService.verifyIdentity(mobile: self.mobileView.textField.text!, name: self.nameView.textField.text!, identityCard: self.idView.textField.text!, smsCode: self.smsView.textField.text!);
        }
    }
    
}
