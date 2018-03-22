//
//  WithdrawViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/6.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class WithdrawViewController: LotteryBaseScrollViewController, ServiceDelegate {

    var availableAmountView: LotteryBaseTextFieldView!;
    var withdrawAmountView: WithdrawTextFieldView!;
    var cardView: LotteryBaseTextFieldView!;
    var actionButton: LotteryBaseButton!;
    var descriptionLabel: UILabel!;
    var hasCancelButton = false;
    var balanceService: BalanceService!;
    
    var withdrawBalance : Double = 0.00;
    
    var bankCardService: BankCardService!;
    var withdrawService: WithdrawService!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "提现";
        
        if (self.hasCancelButton) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction));
        }
        
        //可提金额
        self.availableAmountView = LotteryBaseTextFieldView(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: LotteryBaseTextFieldView.baseHeight));
        self.availableAmountView.label.text = "可提金额：";
        self.availableAmountView.textField.isUserInteractionEnabled = false;
        self.availableAmountView.textField.clearButtonMode = .never;
        self.availableAmountView.textField.textColor = COLOR_RED;
        self.availableAmountView.textField.text = CommonUtil.formatDoubleString(double: self.withdrawBalance) + "元";
        self.scrollView.addSubview(self.availableAmountView);
        
        //提现金额
        self.withdrawAmountView = WithdrawTextFieldView(frame: CGRect(x: 0, y: self.availableAmountView.frame.maxY + 1, width: self.view.frame.width, height: self.availableAmountView.frame.height));
        self.scrollView.addSubview(self.withdrawAmountView);
        self.withdrawAmountView.button.addTarget(self, action: #selector(withdrawAllAction), for: .touchUpInside);
        if (self.withdrawBalance < 10.0) {
            self.withdrawAmountView.textField.isEnabled = false;
            self.withdrawAmountView.label.textColor = COLOR_FONT_SECONDARY;
            self.withdrawAmountView.button.isEnabled = false;
            self.withdrawAmountView.button.layer.borderColor = COLOR_BORDER.cgColor;
        }
        
        //提现银行卡
        self.cardView = LotteryBaseTextFieldView(frame: CGRect(x: 0, y: self.withdrawAmountView.frame.maxY + 1, width: self.view.frame.width, height: self.availableAmountView.frame.height));
        self.cardView.label.text = "提现银行卡：";
        self.cardView.label.font = UIFont.systemFont(ofSize: 13);
        self.cardView.textField.font = UIFont.systemFont(ofSize: 14);
        self.cardView.textField.isUserInteractionEnabled = false;
        self.cardView.textField.clearButtonMode = .never;
        self.cardView.textField.placeholder = "";
        self.scrollView.addSubview(self.cardView);
        
        //actionButton
        self.actionButton = LotteryBaseButton(frame: CGRect(x: 20, y: self.cardView.frame.maxY + 20, width: self.view.frame.width-20*2, height: self.availableAmountView.frame.height));
        self.actionButton.setTitle("提交", for: .normal);
        self.scrollView.addSubview(self.actionButton);
        self.actionButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside);
        
        //说明
        self.descriptionLabel = UILabel(frame: CGRect(x: self.actionButton.frame.minX, y: self.actionButton.frame.maxY+10, width: actionButton.frame.width, height: 100));
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 13);
        self.descriptionLabel.textColor = COLOR_FONT_SECONDARY;
        self.descriptionLabel.numberOfLines = 0;
        self.scrollView.addSubview(self.descriptionLabel);
//        self.descriptionLabel.text = "1、每个账户每天至多提现3次，提现金额至少10元。\n\n2、充值金额、红包不可提现，中奖金额可全部提现。"
        
        //Service
        self.bankCardService = BankCardService(delegate: self);
        self.withdrawService = WithdrawService(delegate: self);
        self.balanceService = BalanceService(delegate: self);
        
        self.bankCardService.queryBankCard();
        self.balanceService.getBalance();
        ViewUtil.showProgressToast();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCompleteSuccess(service: BaseService) {
        ViewUtil.dismissToast();
        if (service == self.bankCardService) {
            self.cardView.textField.text = self.bankCardService.bankCardContent;
        } else if (service == self.withdrawService) {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName)));
            if (self.withdrawService.successTip != nil) {
                let alertController = UIAlertController(title: self.withdrawService.successTip!, message: nil, preferredStyle: .alert);
                alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: { (action) in
                    self.navigationController?.popToRootViewController(animated: true);
                }));
                alertController.show();
            } else {
                ViewUtil.showToast(text: "提现成功");
                self.navigationController?.popToRootViewController(animated: true);
            }
        }else if(service == self.balanceService){
            self.descriptionLabel.text = "1、每个账户每天至多提现\(self.balanceService.withdrawMaxCount)次，提现金额至少\(self.balanceService.withdrawMinAmount)元。\n\n2、充值金额、红包不可提现，中奖金额可全部提现。"
        }
    }
    
    func withdrawAllAction() {
        self.withdrawAmountView.textField.text = CommonUtil.formatDoubleString(double: self.withdrawBalance);
    }
    
    func submitAction() {
        ViewUtil.showProgressToast();
        
        if (self.withdrawBalance < 10.00) {
            ViewUtil.showToast(text: "至少提现10元");
            return;
        }
        
        let withdrawAmount = Double(self.withdrawAmountView.textField.text!);
        if (withdrawAmount == nil) {
            ViewUtil.showToast(text: "请输入正确的提现金额");
        } else if (withdrawAmount! < 10.00) {
            ViewUtil.showToast(text: "至少提现10元");
        } else if (withdrawAmount! > self.withdrawBalance) {
            ViewUtil.showToast(text: "提现金额不能大于可提金额");
        } else {
            self.withdrawService.withdraw(withdrawAmount: self.withdrawAmountView.textField.text!);
        }
    }
    
    func cancelAction() {
        self.navigationController?.popToRootViewController(animated: true);
    }

}
