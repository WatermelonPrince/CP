//
//  ChargeTableViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/19.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class ChargeTableViewController: LotteryBaseTableViewController, ServiceDelegate,UIGestureRecognizerDelegate {
    var chargeAmountCell = ChargeAmountTableViewCell();
    var chargeButton: LotteryBaseButton!;
    var balanceAmount: Double = 0.00;
    
    var balanceService: BalanceService!;
    var chargeService: ChargeService!;
    var chargeCheckPayService: ChargeCheckPayService!;
    
    var paymethod: String = "";
//    var webViewController: LotteryPayWebViewController!;
    var webViewController: LotteryWebViewController!;

    var prepayService: PrepayService!;
    var payMethodList = Array<PayMethod>();

    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "充值";
        
        //NavigationBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction));
        
        //TableView
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);
        //TableFooterView
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: LotteryBaseTextFieldView.baseHeight + 20));
        self.chargeButton = LotteryBaseButton(frame: CGRect(x: 20, y: 0, width: self.tableView.frame.width-20*2, height: LotteryBaseTextFieldView.baseHeight));
        self.chargeButton.setTitle("立即充值", for: .normal);
        self.tableView.tableFooterView?.addSubview(self.chargeButton);
        self.chargeButton.addTarget(self, action: #selector(chargeAction), for: .touchUpInside);
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(textFieldResignAction));
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture);
        
        //Service
        self.balanceService = BalanceService(delegate: self);
        self.chargeService = ChargeService(delegate: self);
        self.chargeCheckPayService = ChargeCheckPayService(delegate: self);
        
        self.prepayService = PrepayService(delegate:self)
        self.prepayService.getPrepayInfo(gameId: nil, orderAmount: 0, isFollow: false)
        
        self.balanceService.getBalance();
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(getPayCallBackInfo), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(setWebViewHidden), name: NSNotification.Name.UIApplicationWillResignActive, object: nil);

    }
    //MARK:Gesture代理
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView" {
            return false
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func onCompleteSuccess(service: BaseService) {
        if (service == self.chargeService) {
            if (self.chargeService.payUrl != nil) {
                if (self.webViewController == nil) {
                    self.webViewController = LotteryWebViewController();
                    self.webViewController.urlContent = self.chargeService.payUrl;
                    self.addChildViewController(self.webViewController);
                    self.view.addSubview(self.webViewController.view);
                } else {
                    self.webViewController.urlContent = self.chargeService.payUrl;
                    self.webViewController.loadWebView();
                }
                self.webViewController.view.isHidden = true;
            } else {
                ViewUtil.showToast(text: "充值失败");
            }
        } else if (service == self.chargeCheckPayService) {
            ViewUtil.dismissToast();
//            self.navigationController?.popToRootViewController(animated: true);
            if (self.chargeCheckPayService.isPaid == true) {
                let alertController = UIAlertController(title: "充值成功", message: nil, preferredStyle: .alert);
                alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
                alertController.show();
            } else {
                let alertController = UIAlertController(title: "充值失败", message: nil, preferredStyle: .alert);
                alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
                alertController.show();
            }
            
            NotificationCenter.default.removeObserver(self);
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName)));
        } else if (service == self.balanceService) {
            self.balanceAmount = self.balanceService.accountBalance;
            self.tableView.reloadData();
        }else if service == self.prepayService{
            self.payMethodList = self.prepayService.payMethodList
            self.paymethod = self.prepayService.payMethodList[0].paymethod!;
            tableView.reloadData()
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 2;
        } else if (section == 1) {
            return 2;
        } else if (section == 2) {
            return self.payMethodList.count + 1;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 40;
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                return 50;
            } else {
                return 110;
            }
        } else {
            return 40;
        }

    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20));
        view.backgroundColor = COLOR_GROUND;
        return view;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = ChargeBaseTableViewCell();
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH);
            if (indexPath.row == 0) {
                var name = LotteryUtil.user()?.name;
                if (name == nil) {
                    name = "";
                }
                cell.textLabel?.text = "账户：" + name!;
            } else {
                cell.textLabel?.text = "余额：" + CommonUtil.formatDoubleString(double: self.balanceAmount) + "元";
            }
            return cell;
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                let cell = ChargeBaseTableViewCell();
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH);
                cell.textLabel?.text = "请选择充值金额";
                return cell;
            } else {
                return self.chargeAmountCell;
            }
        } else if (indexPath.section == 2) {
            let cell = ChargeBaseTableViewCell();
            if (indexPath.row == 0) {
                cell.textLabel?.text = "选择充值方式";
            } else {
                let cell = PayModeTableViewCell();
                let paymethodModel = self.payMethodList[indexPath.row - 1]
                cell.reloadCell(model: paymethodModel, method: self.paymethod)
                return cell;
            }
            return cell;

        }
        return UITableViewCell();
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.isKind(of: PayModeTableViewCell.classForCoder()) == true {
            let payMethodModel = self.payMethodList[indexPath.row - 1]
            self.paymethod = payMethodModel.paymethod!
            self.tableView .reloadData()
        }
    }
    
    func chargeAction(action:UITapGestureRecognizer) {
        
        self.textFieldResignAction();
        
        if (self.chargeAmountCell.selectedAmount != 0) {
            if self.paymethod == "" {
                ViewUtil.showToast(text: "你的余额不足，请到官方网站进行充值...");
                return;
            }
            let chargeAmount = Double(self.chargeAmountCell.selectedAmount);
            self.chargeService.charge(chargeAmount: chargeAmount, paymethod: paymethod);
            ViewUtil.showProgressToast();
        } else {
            ViewUtil.showToast(text: "请选择充值金额");
        }
        
//        if (UIApplication.shared.canOpenURL(CommonUtil.getURL("alipay://")!) == false) {
//            let alertController = UIAlertController(title: "请检查是否已安装支付宝", message: nil, preferredStyle: .alert);
//            alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
//            alertController.show();
//            return;
//        }
        
    }
    
    func textFieldResignAction() {
        self.chargeAmountCell.textField.resignFirstResponder();
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.textFieldResignAction();
    }
    
    func cancelAction() {
        self.navigationController?.popViewController(animated: true);
        NotificationCenter.default.removeObserver(self);
    }
    
    func getPayCallBackInfo() {
        if (self.chargeService.chargeId != nil) {
            ViewUtil.showProgressToast();
            self.chargeCheckPayService.checkChargePay(chargeId: self.chargeService.chargeId);
        }
    }
    
    func setWebViewHidden() {
        if (self.webViewController != nil) {
           self.webViewController.view.isHidden = true;
        }
    }

}
