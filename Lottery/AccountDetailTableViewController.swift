//
//  AccountDetailTableViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class AccountDetailTableViewController: LotteryRefreshTableViewController, ServiceDelegate {
    var headerView: AccountDetailTableHeaderView!;
    var balanceService: BalanceService!;
    var billListService: BillListService!;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "账户明细";
        
        //TableView
        self.tableView.register(AccountDetailTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        
        //HeaderView(不随滚动)
        self.headerView = AccountDetailTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 80));
        
        //Service
        self.balanceService = BalanceService(delegate: self);
        self.billListService = BillListService(delegate: self);
        
        self.beginRefreshing();

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func headerRefresh() {
        self.balanceService.getBalance();
        self.billListService.getBillList();
    }
    
    override func footerRefresh() {
        super.footerRefresh();
        self.billListService.getBillList(page: self.billListService.page + 1)
    }
    
    override func onCompleteSuccess(service: BaseService) {
        if (service == self.balanceService) {
            self.headerView.setData(balanceAmount: self.balanceService.accountBalance, freezeAmount: self.balanceService.freezeAmount);
        } else if (service == self.billListService) {
            if (self.billListService.hasNextPage != nil) {
                self.hasNoMoreData = !self.billListService.hasNextPage!;
            }
            self.loadSuccess();
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.billListService.billList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90;
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 90));
        view.backgroundColor = COLOR_GROUND;
        view.addSubview(self.headerView);
        return view;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AccountDetailTableViewCell;
        cell.setData(bill: self.billListService.billList[indexPath.row]);
        return cell;
    }

}
