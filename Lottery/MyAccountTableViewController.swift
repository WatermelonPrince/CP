//
//  MyAccountTableViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MyAccountTableViewController: LotteryRefreshTableViewController, ServiceDelegate {
    var headerView: MyAccountTableHeaderView!;
    var balanceService: BalanceService!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的账户";
        
        //TableHeaderView
        self.headerView = MyAccountTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 200));
        self.tableView.tableHeaderView = self.headerView;
        self.headerView.withdrawButton.addTarget(self, action: #selector(withdrawAction), for: .touchUpInside);
        self.headerView.chargeButton.addTarget(self, action: #selector(chargeAction), for: .touchUpInside);
        
        //BalanceService
        self.balanceService = BalanceService(delegate: self);
        self.beginRefreshing();
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(beginRefreshing), name: NSNotification.Name(rawValue: MineViewController.userStatusChangeNotificationName), object: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    override func headerRefresh() {
        self.balanceService.getBalance();
    }
    
    override func onCompleteSuccess(service: BaseService) {
        self.headerView.setData(accountBalance: self.balanceService.accountBalance, freezeAmount: self.balanceService.freezeAmount);
        self.tableView.mj_header.endRefreshing();
    }
    
    override func onCompleteFail(service: BaseService) {
        self.tableView.mj_header.endRefreshing();
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20));
        view.backgroundColor = COLOR_GROUND;
        return view;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsTableViewCell();
        cell.accessoryType = .disclosureIndicator;
        if (indexPath.row == 0) {
            cell.imageView?.image = UIImage(named: "icon_myaccount_id");
            cell.textLabel?.text = "身份验证";
        } else if (indexPath.row == 1) {
            cell.imageView?.image = UIImage(named: "icon_myaccount_bankcard");
            cell.textLabel?.text = "绑定银行卡";
        } else if (indexPath.row == 2) {
            cell.imageView?.image = UIImage(named: "icon_myaccount_account");
            cell.textLabel?.text = "账户明细";
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        if (self.balanceService.hasIdentity == nil && indexPath.row != 2) {
            ViewUtil.showToast(text: "重新获取信息...");
            self.beginRefreshing();
        } else {
            if (indexPath.row == 0) {
                let vc = IdentityVerifyViewController();
                vc.hasIdentity = self.balanceService.hasIdentity;
                self.pushViewController(viewController: vc);
            } else if (indexPath.row == 1) {
                if (self.balanceService.hasIdentity == nil) {
                    ViewUtil.showToast(text: "重新获取信息...");
                    self.beginRefreshing();
                } else if (self.balanceService.hasIdentity == false) {
                    let vc = IdentityVerifyViewController();
                    vc.shouldNavBankCard = true;
                    self.pushViewController(viewController: vc);
                } else {
                    let vc = BankCardViewController();
                    vc.hasBankCard = self.balanceService.hasBankCard;
                    self.pushViewController(viewController: vc);
                }
            } else if (indexPath.row == 2) {
                self.pushViewController(viewController: AccountDetailTableViewController());
            }
        }
        
    }
    
    func withdrawAction() {
        if (self.balanceService.hasIdentity == nil) {
            ViewUtil.showToast(text: "重新获取信息...");
            self.beginRefreshing();
        } else if (self.balanceService.hasIdentity == false) {
            let vc = IdentityVerifyViewController();
            vc.shouldNavWithdraw = true;
            self.pushViewController(viewController: vc);
        } else if (self.balanceService.hasBankCard == false) {
            let vc = BankCardViewController();
            vc.shouldNavWithdraw = true;
            self.pushViewController(viewController: vc);
        } else {
            let vc = WithdrawViewController();
            vc.withdrawBalance = self.balanceService.withdrawBalance;
            self.pushViewController(viewController: vc);
        }
        
    }
    
    func chargeAction() {
        let vc = ChargeTableViewController();
        vc.balanceAmount = self.balanceService.accountBalance;
        self.pushViewController(viewController: vc);
    }

}
