//
//  BankCardViewController.swift
//  Lottery
//
//  Created by DTY on 2017/5/8.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class BankCardViewController: LotteryBaseScrollViewController, ServiceDelegate {

    var holderNameView: LotteryBaseTextFieldView!;
    var cardView: BankCardTextFieldView!;
    var mobileView: MobileTextFieldView!;
    var verifyView: VerifyTextFieldView!;
    var voiceVerifyButton: VoiceVerifyButton!;
    var actionButton: LotteryBaseButton!;
    
    var bankCardService: BankCardService!;
    
    var hasBankCard = false;
    var shouldNavWithdraw = false;
    var hasCancelButton = false;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "绑定银行卡";
        if (self.hasBankCard) {
            self.title = "我的银行卡";
        }
        
        if (self.hasCancelButton) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction));
        }
        
        let questionMarkButton = QuestionMarkButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
        questionMarkButton.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        questionMarkButton.setTitleColor(COLOR_WHITE, for: .normal);
        questionMarkButton.layer.borderColor = COLOR_WHITE.cgColor;
        questionMarkButton.addTarget(self, action: #selector(helpBankCardAction), for: .touchUpInside);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: questionMarkButton);
        
        //Description
        let descriptionLabel = UILabel(frame: CGRect(x: 15, y: 0, width: self.view.frame.width-15*2, height: LotteryBaseTextFieldView.baseHeight));
        descriptionLabel.font = UIFont.systemFont(ofSize: 14);
        descriptionLabel.textColor = COLOR_FONT_SECONDARY;
        self.scrollView.addSubview(descriptionLabel);
        descriptionLabel.text = "请绑定需要提现的银行卡";
        descriptionLabel.isHidden = self.hasBankCard;
        
        //持卡人
        self.holderNameView = BankCardHolderTextFieldView(frame: CGRect(x: 0, y: descriptionLabel.frame.maxY, width: self.view.frame.width, height: LotteryBaseTextFieldView.baseHeight));
        self.holderNameView.textField.isEnabled = false;
        self.scrollView.addSubview(self.holderNameView);
        if (self.hasBankCard) {
            self.holderNameView.frame.origin.y = 20;
            self.holderNameView.textField.placeholder = "";
        }
        
        //银行卡号
        self.cardView = BankCardTextFieldView(frame: CGRect(x: 0, y: self.holderNameView.frame.maxY + 1, width: self.view.frame.width, height: self.holderNameView.frame.height));
        self.scrollView.addSubview(self.cardView);
        self.cardView.textField.isEnabled = !self.hasBankCard;
        if (self.hasBankCard) {
            self.cardView.label.text = "银行卡：";
            self.cardView.textField.placeholder = "";
        }
        
//        //预留手机号码
//        self.mobileView = MobileTextFieldView(frame: CGRect(x: 0, y: self.cardView.frame.maxY + 20, width: self.view.frame.width, height: self.holderNameView.frame.height));
//        self.mobileView.label.text = "预留手机号：";
//        self.mobileView.textField.placeholder = "输入银行预留手机号";
//        self.scrollView.addSubview(self.mobileView);
//        
//        //验证码
//        self.verifyView = VerifyTextFieldView(frame: CGRect(x: 0, y: self.mobileView.frame.maxY + 1, width: self.view.frame.width, height: self.holderNameView.frame.height));
//        self.scrollView.addSubview(self.verifyView);
//        self.verifyView.button.addTarget(self, action: #selector(verifyAction), for: .touchUpInside);
//        
//        //语音验证码
//        self.voiceVerifyButton = VoiceVerifyButton(frame: CGRect(x: self.view.frame.width - 200 - 20, y: self.verifyView.frame.maxY + 10, width: 200, height: 16));
//        self.scrollView.addSubview(self.voiceVerifyButton);
//        self.voiceVerifyButton.addTarget(self, action: #selector(voiceVerifyAction), for: .touchUpInside);
        
        //actionButton
        self.actionButton = LotteryBaseButton(frame: CGRect(x: 20, y: self.cardView.frame.maxY + 20, width: self.view.frame.width-20*2, height: self.holderNameView.frame.height));
        self.actionButton.setTitle("提交", for: .normal);
        self.scrollView.addSubview(self.actionButton);
        self.actionButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside);
        self.actionButton.isHidden = self.hasBankCard;
        
        self.bankCardService = BankCardService(delegate: self);
        
        self.bankCardService.queryBankCard();
        ViewUtil.showProgressToast();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCompleteSuccess(service: BaseService) {
        ViewUtil.dismissToast();
        self.holderNameView.textField.text = self.bankCardService.name;
        self.cardView.textField.text = self.bankCardService.bankCardContent;
        if (self.hasBankCard == false && self.bankCardService.submitSuccess == true) {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName)));
            ViewUtil.showToast(text: "银行卡绑定成功");
            if (self.shouldNavWithdraw) {
                let vc = WithdrawViewController();
                vc.hasCancelButton = true;
                self.pushViewController(viewController: vc);
            } else {
                self.navigationController?.popToRootViewController(animated: true);
            }
        }
    }
    
    func verifyAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入预留手机号");
        } else {
            self.verifyView.createVerifyTimer();
            //Todo
        }
    }
    
    func voiceVerifyAction() {
        if (self.mobileView.textField.text == "") {
            ViewUtil.showToast(text: "请输入预留手机号");
        } else {
            //Todo
        }
    }
    
    func submitAction() {
        if (self.cardView.textField.text == ""){
            ViewUtil.showToast(text: "请输入银行卡号");
        } else {
            ViewUtil.showProgressToast();
            self.bankCardService.bindBankCard(bankCardNumber: self.cardView.textField.text!);
        }
    }
    
    func helpBankCardAction() {
        LotteryRoutes.routeURLString(HTTPConstants.HELP_BANKCARD);
    }
    
    func cancelAction() {
        self.navigationController?.popToRootViewController(animated: true);
    }

}
