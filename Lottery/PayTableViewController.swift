//
//  PayTableViewController.swift
//  Lottery
//
//  Created by DTY on 2017/4/11.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit
class PayTableViewController: LotteryBaseTableViewController, ServiceDelegate {
    var payButton: LotteryBaseButton!;
    var moreRedPacketTableView: PayMoreRedPacketTableView!;
    var maskButton: UIButton!;
    
    var orderAmount: Double = 0.00;
    var balanceAmount: Double = 0.00;
    var redPacketAmount: Double = 0.00;
    var redPacketId: Int?;
    var isRedPacketShow = false;
    var isBalnceUsed = true;
    var redPacketList = Array<RedPacket>();
    var payMethodList = Array<PayMethod>();
    var shownRedPacketList = Array<RedPacket>();
    var redPacketCell = PayRedPacketTableViewCell();
    var balancePayAmount: Double = 0.00;
    var redPacketPayAmount: Double = 0.00;
    var needPayAmount: Double = 0.00;
    var gameExtra: String!;
    
    var gameId:Int!;
    var gameEn: String!;
    var gameName: String!;
    var periodId: String!;
    
    var followMode: Int!;
    var totalPeriod: Int!;
    
    var betTimes: Int!;
    var lotteryNumber: String!;
    var paymethod: String = "";
    
    var oderToPayService: OrderToPayService!
    var betService: BetService!;
    var orderBuyService: OrderBuyService!;
    var orderCheckPayService: OrderCheckPayService!;
    var orderId: String!;
    
    var deadlineTimer: Timer?;
    var deadlineTimeInterval: TimeInterval = MAX_TIME_INTERVAL;
    var webViewController: LotteryWebViewController!;


    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.title = "支付";
        self.paymethod = self.payMethodList[0].paymethod!;
        
        //NavigationBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction));
        
        //TableView
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);
        //TableFooterView
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: LotteryBaseTextFieldView.baseHeight + 50));
        self.payButton = LotteryBaseButton(frame: CGRect(x: 20, y: 10, width: self.tableView.frame.width-20*2, height: LotteryBaseTextFieldView.baseHeight));
        self.payButton.setTitle("立即支付", for: .normal);
        self.tableView.tableFooterView?.addSubview(self.payButton);
        self.payButton.addTarget(self, action: #selector(payAction), for: .touchUpInside);
        
        //MaskButton
        self.maskButton = UIButton(frame: self.view.bounds);
        self.maskButton.backgroundColor = COLOR_MASK;
        self.view.addSubview(self.maskButton);
        self.maskButton.alpha = 0;
        self.maskButton.addTarget(self, action: #selector(maskAction), for: .touchUpInside);
        
        //MoreRedPacketTableView
        self.moreRedPacketTableView = PayMoreRedPacketTableView(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height*0.7));
        self.moreRedPacketTableView.redPacketList = self.redPacketList;
        self.view.addSubview(self.moreRedPacketTableView);
        
        if (self.redPacketList.count > 0 && self.redPacketList[0].usable == true) {
            self.redPacketAmount = self.redPacketList[0].balance!;
            self.redPacketId = self.redPacketList[0].redPacketId;
        }
        
        for redPacket in self.redPacketList.enumerated() {
            if (redPacket.offset < 3) {
                self.shownRedPacketList.append(redPacket.element);
            } else {
                break;
            }
        }
        
        self.updateNeedPayAmount();
        
        //Observer
        NotificationCenter.default.addObserver(self, selector: #selector(redPacketDidSelectedAction), name: NSNotification.Name(rawValue: "RedPacketDidSelectAction"), object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(moreRedPacketDidSelectAction), name: NSNotification.Name(rawValue: "MoreRedPacketDidSelectAction"), object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(getPayCallBackInfo), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(setWebViewHidden), name: NSNotification.Name.UIApplicationWillResignActive, object: nil);
        
        //Service
        self.betService = BetService(delegate: self);
        self.getPeriodInfo();
        self.orderBuyService = OrderBuyService(delegate: self);
        self.orderCheckPayService = OrderCheckPayService(delegate: self);
        self.oderToPayService = OrderToPayService(delegate:self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.deadlineTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(deadlineTimerAction), userInfo: nil, repeats: true);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.deadlineTimer?.invalidate();
        self.deadlineTimer = nil;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    //支付成功或者订单生成成功回调
    func onCompleteSuccess(service: BaseService) {
        if (service == self.oderToPayService) {
            if (self.needPayAmount > 0.00) {
                if self.oderToPayService.payUrl != nil {
                    if (self.webViewController == nil) {
                        self.webViewController = LotteryWebViewController();
                        self.webViewController.urlContent = self.oderToPayService.payUrl;
                        self.addChildViewController(self.webViewController);
                        self.view.addSubview(self.webViewController.view);
                    } else {
                        self.webViewController.urlContent = self.oderToPayService.payUrl;
                        self.webViewController.loadWebView();
                    }
                    self.webViewController.view.isHidden = true;
                } else {
                    ViewUtil.showToast(text: "支付失败");
                    self.navigationController?.popToRootViewController(animated: true)
                }

            } else {
                ViewUtil.dismissToast();
                self.navigationController?.popToRootViewController(animated: true);
                let alertController = UIAlertController(title: "支付成功", message: nil, preferredStyle: .alert);
                alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
                alertController.show();
                NotificationCenter.default.removeObserver(self);
            }
            
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName)));
        }else if (service == self.orderBuyService) {
            self.oderToPayService.continueToPay(orderId: self.orderBuyService.orderId, paymethod: self.paymethod)
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName)));
            
        }else if (service == self.betService) {
            let endTime = self.betService.currentPeriod.saleEndTime;
            if (endTime != nil) {
                self.deadlineTimeInterval = Double(endTime!);
            }
            let currentPeriodId = self.betService.currentPeriod.periodId;
            
            if (self.periodId == "--") {
                self.periodId = currentPeriodId;
                self.gameId = self.betService.currentPeriod.gameId;
                self.tableView.reloadData();
            }
            
            if (currentPeriodId != nil && self.periodId != currentPeriodId && self.orderBuyService.currentPeriodId != currentPeriodId) {
                self.orderBuyService.currentPeriodId = currentPeriodId;
                let alertController = UIAlertController(title: "期次改变提示", message: "第\(self.periodId!)期已截止，当前是第\(currentPeriodId!)期，确定继续投注？", preferredStyle: .alert);
                alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil));
                alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
                    self.periodId = currentPeriodId;
                    self.tableView.reloadData();
                }));
                alertController.show();
            }
        } else if (service == self.orderCheckPayService) {
            ViewUtil.dismissToast();
            self.navigationController?.popToRootViewController(animated: true);
            if (self.orderCheckPayService.isPaid == true) {
                let alertController = UIAlertController(title: "支付成功", message: nil, preferredStyle: .alert);
                alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
                alertController.show();
            } else {
                let alertController = UIAlertController(title: "支付失败", message: nil, preferredStyle: .alert);
                alertController.addAction(UIAlertAction(title: "好的", style: .cancel, handler: nil));
                alertController.show();
            }
            NotificationCenter.default.removeObserver(self);
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: MineViewController.userStatusChangeNotificationName)));
        }
    }
    
    func onCompleteFail(service: BaseService) {
        if (self.betService.currentPeriod == nil) {
            self.deadlineTimeInterval = -1;
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            if (self.balanceAmount == 0.00 && self.self.shownRedPacketList.count == 0) {
                return 3;
            } else if (self.balanceAmount > 0.00 && self.self.shownRedPacketList.count == 0) {
                return 4;
            } else if (self.shownRedPacketList.count > 0 && self.balanceAmount == 0.00){
                if (self.orderId == nil) {
                    return 5;
                } else {
                    return 4;
                }
            } else if (self.shownRedPacketList.count > 0 && self.balanceAmount > 0.00) {
                if (self.orderId == nil) {
                    return 6;
                } else {
                    return 5;
                }
            }
        } else {
            if (self.needPayAmount == 0.00) {
                return 0;
            }
            return self.payMethodList.count+1;
        }
        
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            if (self.isRedPacketShow == true) {
                if (self.shownRedPacketList.count > 0 && self.balanceAmount == 0) {
                    if (indexPath.row == 3) {
                        return SCREEN_WIDTH*0.2+150;
                    }
                } else if (self.shownRedPacketList.count > 0 && self.balanceAmount > 0) {
                    if (indexPath.row == 4) {
                        return SCREEN_WIDTH*0.2+150;
                    }
                }
            }
            
        }
        return 40;
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
            let numberOfRows = tableView.numberOfRows(inSection: 0);
            
            if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == numberOfRows-1) {
                let cell = PayInfoTableViewCell();
                
                if (indexPath.row == 0) {
                    cell.textLabel?.text = "彩种信息";
                    if (self.totalPeriod == nil) {
                        if (periodId == nil) {
                           self.periodId = "--";
                        }
                        cell.detailTextLabel?.text = "\(self.gameName!) 第\(self.periodId!)期";
                    } else {
                        cell.detailTextLabel?.text = "\(self.gameName!) 追\(self.totalPeriod!)期";
                    }
                    
                } else if (indexPath.row == 1) {
                    cell.textLabel?.text = "订单金额";
                    cell.detailTextLabel?.text = CommonUtil.formatDoubleString(double: self.orderAmount) + "元";
                    cell.detailTextLabel?.textColor = COLOR_RED;
                    if (tableView.numberOfRows(inSection: 0) == 3) {
                        cell.detailTextLabel?.textColor = COLOR_FONT_TEXT;
                    }
                } else if (indexPath.row == numberOfRows-1) {
                    cell.textLabel?.text = "还需支付";
                    self.updateNeedPayAmount();
                    cell.detailTextLabel?.text = CommonUtil.formatDoubleString(double: self.needPayAmount) + "元";
                    cell.detailTextLabel?.textColor = COLOR_RED;
                }
                return cell;
            }
            
            if (self.balanceAmount > 0) {
                if (indexPath.row == 2) {
                    let cell = PayBalanceTableViewCell();
                    if self.balanceAmount < self.orderAmount - self.redPacketAmount {
                        self.balancePayAmount = self.balanceAmount;
                    }else{
                        self.balancePayAmount = self.orderAmount - self.redPacketAmount
                    }
                   
                    if (self.balancePayAmount < 0.00 || self.isBalnceUsed == false) {
                        self.balancePayAmount = 0.00;
                    }
                    cell.balanceDetailLabel.text = CommonUtil.formatDoubleString(double: -self.balancePayAmount) + "元";
                    if (self.balancePayAmount > 0.00) {
                        cell.accessoryView = UIImageView(image: UIImage(named: "icon_selected"));
                        cell.balanceDetailLabel.textColor = COLOR_FONT_TEXT;
                    } else {
                        cell.accessoryView = UIImageView(image: UIImage(named: "icon_unselected"));
                        cell.balanceDetailLabel.textColor = COLOR_FONT_SECONDARY;
                    }
                    
                    if (self.orderId == nil) {
                        cell.accessoryType = .none;
                    }
                    
                    return cell;
                }
            }
            
            if (self.redPacketList.count > 0) {
                if (indexPath.row == numberOfRows-3) {
                    let cell = PayInfoTableViewCell();
                    cell.textLabel?.text = " 红包抵扣";
                    if (self.orderAmount < self.redPacketAmount) {
                        self.redPacketPayAmount = self.orderAmount;
                    } else {
                        self.redPacketPayAmount = self.redPacketAmount;
                    }
                    
                    cell.detailTextLabel?.text = CommonUtil.formatDoubleString(double: -self.redPacketPayAmount) + "元";
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH);
                
                    return cell;
                }
                
                if (indexPath.row == numberOfRows-2) {
                    let cell = self.redPacketCell;
                    cell.setData(redPacketList: self.shownRedPacketList);
                    cell.detailButton.isSelected = self.isRedPacketShow;
                    cell.isRedPacketHidden = !self.isRedPacketShow;
                    cell.detailButton.addTarget(self, action: #selector(redPacketDetailAction), for: .touchUpInside);
                    cell.moreButton.addTarget(self, action: #selector(redPacketMoreAction), for: .touchUpInside);
                    return cell;
                }
            }
            
        } else {
            if (indexPath.row == 0) {
                let cell = PayInfoTableViewCell();
                cell.textLabel?.text = "选择支付方式";
                return cell;
            } else {
                let cell = PayModeTableViewCell();
                let paymethodModel = self.payMethodList[indexPath.row - 1]
                cell.reloadCell(model: paymethodModel, method: self.paymethod)
                return cell;
            }
            
        }
        
        return UITableViewCell();
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath)?.isKind(of: PayBalanceTableViewCell.classForCoder()) == true && self.orderId == nil) {
            self.isBalnceUsed = !self.isBalnceUsed;
            self.updateNeedPayAmount();
            tableView.reloadData();
        }
        
        //选择支付方式
        if tableView.cellForRow(at: indexPath)?.isKind(of: PayModeTableViewCell.classForCoder()) == true {
            let payMethodModel = self.payMethodList[indexPath.row - 1]
                self.paymethod = payMethodModel.paymethod!
          
           
            self.tableView .reloadData()
        }
    }
    
    func redPacketDetailAction() {
        self.isRedPacketShow = !self.isRedPacketShow;
        self.tableView.reloadData();
    }
    
    func redPacketMoreAction() {
        UIView.animate(withDuration: 0.3) { 
            self.maskButton.alpha = 1;
            self.moreRedPacketTableView.frame.origin.y = self.view.frame.height*0.3;
        }
        self.moreRedPacketTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false);
        self.moreRedPacketTableView.isUserInteractionEnabled = true;
    }
    
    func maskAction() {
        UIView.animate(withDuration: 0.5) {
            self.maskButton.alpha = 0;
            self.moreRedPacketTableView.frame.origin.y = self.view.frame.height;
        }
        self.moreRedPacketTableView.isUserInteractionEnabled = false;
    }
    
    func moreRedPacketDidSelectAction(_ notificaiton: Notification) {
        self.maskAction();
        
        let row = notificaiton.object as! Int;
        
        if (self.redPacketCell.useRedPacket.redPacketId == self.redPacketList[row].redPacketId) {
            return;
        }
        
        if (row == 1) {
            self.redPacketCell.middleButton.sendActions(for: .touchUpInside);
        } else if (row == 2) {
            self.redPacketCell.rightButton.sendActions(for: .touchUpInside);
        } else {
            self.shownRedPacketList[0] = self.redPacketList[row];
            self.redPacketCell.isInitial = true;
            self.redPacketCell.setData(redPacketList: self.shownRedPacketList);
        }
        
    }
    
    func redPacketDidSelectedAction(_ notification: Notification) {
        let redPacket = notification.object as? RedPacket;
        if (redPacket != nil) {
            self.redPacketAmount = redPacket!.balance!;
        } else {
            self.redPacketAmount = 0.00;
        }
        self.redPacketId = redPacket?.redPacketId;
        self.updateNeedPayAmount();
        self.tableView.reloadData();
    }
    
    func updateNeedPayAmount() {
        self.needPayAmount = self.orderAmount - self.balanceAmount - self.redPacketAmount;
        if (self.isBalnceUsed == false) {
            self.needPayAmount = self.orderAmount - self.redPacketAmount;
        }
        if (self.needPayAmount < 0.00) {
            self.needPayAmount = 0.00;
        }
    }
    
    func cancelAction() {
        let alertController = UIAlertController(title: nil, message: "大奖不等人，请三思而行", preferredStyle: .alert);
        let popAction = UIAlertAction(title: "去意已决", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true);
            NotificationCenter.default.removeObserver(self);
        }
        let cancelAction = UIAlertAction(title: "我再想想", style: .default, handler: nil);
        alertController.addAction(popAction);
        alertController.addAction(cancelAction);
        alertController.show();
    }
    //MARK:支付事件
    func payAction() {
        if (self.orderId != nil) {
            self.oderToPayService.continueToPay(orderId: self.orderId, paymethod: self.paymethod);
        } else if (self.totalPeriod == nil) {//普通投注
            self.orderBuyService.orderAdd(gameId: self.gameId, periodId: self.periodId, betTimes: self.betTimes, lotteryNumber: self.lotteryNumber, amount: self.orderAmount, balancePay: self.balancePayAmount, needPay: self.needPayAmount, paymethod: self.paymethod, gameExtra: self.gameExtra, redPacketId: self.redPacketId);
        } else {//追号
            self.orderBuyService.followBuy(gameId: self.gameId, followMode: self.followMode, followType: 0, totalPeriod: self.totalPeriod, periodId: self.periodId, betTimes: self.betTimes, lotteryNumber: self.lotteryNumber, amount: self.orderAmount, balancePay: self.balancePayAmount, needPay: self.needPayAmount, paymethod: self.paymethod, gameExtra: self.gameExtra, redPacketId: self.redPacketId);
        }
    }
    
    func deadlineTimerAction() {
        
        if (self.deadlineTimeInterval > 0 && self.deadlineTimeInterval != MAX_TIME_INTERVAL) {
            self.deadlineTimeInterval -= 1;
        }
        
        if (self.deadlineTimeInterval == 0) {
            self.betService.getPeriods(gameEn: self.gameEn);
        }
        
    }
    
    func getPeriodInfo() {
        self.betService.getPeriods(gameEn: self.gameEn);
        self.deadlineTimeInterval = MAX_TIME_INTERVAL;
    }
    
    func getPayCallBackInfo() {
        if (self.oderToPayService.orderId != nil) {
            //每次进入前台检查 当前订单号不为空的情况下，支付是否完成
            ViewUtil.showProgressToast();
            self.orderCheckPayService.checkOrderPay(orderId: self.oderToPayService.orderId);
        }
    }
    
    func setWebViewHidden() {
        if (self.webViewController != nil) {
            self.webViewController.view.isHidden = true;
        }
    }

}
