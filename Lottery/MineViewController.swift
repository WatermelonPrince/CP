//
//  MineViewController.swift
//  Lottery
//
//  Created by DTY on 17/1/17.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class MineViewController: LotteryRefreshTableViewController, ServiceDelegate, VTMagicViewDelegate {
    static let userStatusChangeNotificationName = "UserStatusChange";

    var headerView: MineTableHeaderView!;
    var emptyFooterView: MineEmptyTableFooterView!;
    var magicViewController: MineOrderMagicViewController!;
    var userService: UserService!;
    var orderListService: OrderListService!;
    var balanceService: BalanceService!;
    var orderStatus: Int!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我";
        
        //NavigationBar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_settings"), style: .done, target: self, action: #selector(settingsAction));
        
        //TableView
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(MineTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        self.tableView.mj_footer.isHidden = false;
        
        //HeaderView
        self.headerView = MineTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 186));
        self.tableView.tableHeaderView = self.headerView;
        self.headerView.avatarButton.addTarget(self, action: #selector(nickNameAction), for: .touchUpInside);
        self.headerView.nickNameButton.addTarget(self, action: #selector(nickNameAction), for: .touchUpInside);
        self.headerView.balanceButton.addTarget(self, action: #selector(myAccountAction), for: .touchUpInside);
        self.headerView.withdrawButton.addTarget(self, action: #selector(withdrawAction), for: .touchUpInside);
        self.headerView.chargeButton.addTarget(self, action: #selector(chargeAction), for: .touchUpInside);
        self.headerView.redPacketButton.addTarget(self, action: #selector(redPacketAction), for: .touchUpInside);
        
        //FooterView
        self.emptyFooterView = MineEmptyTableFooterView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 300));
        self.emptyFooterView.emptyButton.addTarget(self, action: #selector(emptyReloadAction), for: .touchUpInside);
        
        //MagicViewController
        self.magicViewController = MineOrderMagicViewController();
        self.addChildViewController(self.magicViewController);
        self.magicViewController.magicView.frame = CGRect(x: 0, y: 0, width: self.headerView.frame.width, height: self.magicViewController.magicView.navigationHeight);
        self.magicViewController.magicView.reloadData();
        self.magicViewController.magicView.delegate = self;
        
        //Swipe
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)));
        leftSwipeGestureRecognizer.direction = .left;
        self.tableView.addGestureRecognizer(leftSwipeGestureRecognizer);
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)));
        rightSwipeGestureRecognizer.direction = .right;
        self.tableView.addGestureRecognizer(rightSwipeGestureRecognizer);
        self.tableView.isUserInteractionEnabled = true;
        
        self.userService = UserService(delegate: self);
        self.orderListService = OrderListService(delegate: self);
        self.balanceService = BalanceService(delegate: self);
        
        self.headerView.setUser(user: LotteryUtil.user());
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(beginRefreshing), name: NSNotification.Name(rawValue: MineViewController.userStatusChangeNotificationName), object: nil);
        
        self.beginRefreshing();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
//当一些状态改变状态改变的时候，刷新用户信息，已登录的重新请求user信息
    override func headerRefresh() {
        if (LotteryUtil.isLogin()) {
            self.userService.getUser();
            self.orderListService.getOrderList(status: self.orderStatus);
            //红包数，余额数请求接口
            self.balanceService.getBalance();
            self.magicViewController.magicView.isSwitchEnabled = false;
        } else {
            self.orderListService.orderList.removeAll();
            self.orderListService.hasNextPage = false;
            self.balanceService.accountBalance = 0.00;
            self.balanceService.redPacketCount = 0;
            self.onCompleteSuccess(service: self.userService);
            self.onCompleteSuccess(service: self.orderListService);
            self.onCompleteSuccess(service: self.balanceService);
            self.tableView.mj_header.endRefreshing();
        }
    }
    
    override func footerRefresh() {
        super.footerRefresh();
        self.magicViewController.magicView.isSwitchEnabled = false;
        self.orderListService.getOrderList(page: self.orderListService.page + 1, status: self.orderStatus);
    }
    
    override func emptyReloadAction() {
        self.emptyFooterView.emptyButton.setTitle("加载中...", for: .disabled);
        self.emptyFooterView.emptyButton.isEnabled = false;
        self.beginRefreshing();
    }
    
    override func onCompleteSuccess(service: BaseService) {
        if (service == self.userService) {
           self.headerView.setUser(user: LotteryUtil.user());
        } else if (service == self.orderListService) {
            if (self.orderListService.hasNextPage != nil) {
               self.hasNoMoreData = !self.orderListService.hasNextPage!;
            }
            self.loadSuccess();
            self.magicViewController.magicView.isSwitchEnabled = true;
            
            if (self.tableView.numberOfRows(inSection: 0) == 0) {
                self.emptyFooterView.emptyButton.isEnabled = false;
                self.emptyFooterView.emptyButton.setTitle("暂无订单记录", for: .disabled);
                self.tableView.tableFooterView = self.emptyFooterView;
            }
        } else  if (service == self.balanceService) {
            self.headerView.setBalance(balance: self.balanceService.accountBalance);
            self.headerView.setRedPacketCount(count: self.balanceService.redPacketCount);
        }
        
    }
    
    override func onCompleteFail(service: BaseService) {
        if (service == self.orderListService) {
            self.magicViewController.magicView.isSwitchEnabled = true;
            self.loadFail();
            if (self.tableView.numberOfRows(inSection: 0) == 0) {
                self.emptyFooterView.emptyButton.isEnabled = true;
                self.emptyButton.descriptionLabel.text = "点击重新加载";
                self.tableView.tableFooterView = self.emptyFooterView;
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListService.orderList.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.magicViewController.magicView.frame.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.magicViewController.magicView;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MineTableViewCell;
        let orderList = self.orderListService.orderList;
        cell.setData(order: orderList[indexPath.row]);
        
        if (indexPath.row != 0) {
            let dateArray = LotteryUtil.orderListDateArray(content: orderList[indexPath.row].createTime!);
            let lastDateArray = LotteryUtil.orderListDateArray(content: orderList[indexPath.row-1].createTime!);
            if (dateArray == lastDateArray) {
                cell.monthLabel.isHidden = true;
                cell.dayLabel.isHidden = true;
            } else {
                cell.monthLabel.isHidden = false;
                cell.dayLabel.isHidden = false;
            }
        } else {
            cell.monthLabel.isHidden = false;
            cell.dayLabel.isHidden = false;
        }

        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let orderList = self.orderListService.orderList;
        let order = orderList[indexPath.row];
        
        let orderDetail = OrderDetail();
        orderDetail.orderId = order.orderId;
        orderDetail.gameId = order.gameId;
        orderDetail.gameName = order.gameName;
        orderDetail.periodId = order.periodId;
        orderDetail.orderType = order.orderType;
        orderDetail.orderStatus = order.orderStatus;
        orderDetail.prizeStatus = order.prizeStatus;
        orderDetail.orderAmount = order.orderAmount;
        
        let vc = MineOrderDetailTableViewController();
        vc.orderDetail = orderDetail;
        self.pushViewController(viewController: vc);
        
    }
    
    func nickNameAction() {
        if (LotteryUtil.isLogin() != true) {
            LotteryUtil.shouldLogin();
        } else {
            self.pushViewController(viewController: MineBasicInfoTableViewController());
        }
    }
    
    func settingsAction() {
        self.pushViewController(viewController: SettingsViewController());
    }
    
    func myAccountAction() {
        LotteryUtil.shouldLogin();
        if (LotteryUtil.isLogin()) {
           self.pushViewController(viewController: MyAccountTableViewController());
        }
    }
    
    func withdrawAction() {
        LotteryUtil.shouldLogin();
        if (LotteryUtil.isLogin()) {
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
    }
    
    func chargeAction() {
        LotteryUtil.shouldLogin();
        if (LotteryUtil.isLogin()) {
            let vc = ChargeTableViewController();
            vc.balanceAmount = self.balanceService.accountBalance;
            self.pushViewController(viewController: vc);
        }
    }
    
    func redPacketAction() {
        LotteryUtil.shouldLogin();
        if (LotteryUtil.isLogin()) {
            self.pushViewController(viewController: RedPacketMagicViewController());
        }
    }
    
    func swipeAction(_ recognizer: UISwipeGestureRecognizer) {
        if (self.tableView.mj_header.isRefreshing() || self.tableView.mj_footer.isRefreshing()) {
            return;
        }
        
        var page = self.magicViewController.currentPage;
        if (recognizer.direction == .left) {
            if (page == 2) {
                return;
            }
            page = page + 1;
        } else if (recognizer.direction == .right) {
            if (page == 0) {
                return;
            }
            page = page - 1;
        }
        
        self.selectMagicItem(page: Int(page));
        
        self.magicViewController.switch(toPage: UInt(page), animated: true);
        
    }
    
    func magicView(_ magicView: VTMagicView, didSelectItemAt itemIndex: UInt) {
        if (itemIndex != self.magicViewController.currentPage) {
            self.selectMagicItem(page: Int(itemIndex));
        }
    }
    
    func selectMagicItem(page: Int) {
        if (page == 0) {
            self.orderStatus = nil;
        } else {
            self.orderStatus = page;
        }
        self.orderListService.orderList.removeAll();
        self.orderListService.page = 1;
        self.orderListService.hasNextPage = false;
        self.tableView.reloadData();
        self.beginRefreshing();
    }
}
