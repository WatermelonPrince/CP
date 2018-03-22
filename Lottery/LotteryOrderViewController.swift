//
//  LotteryOrderBaseViewController.swift
//  Lottery
//
//  Created by DTY on 17/2/4.
//  Copyright © 2017年 caipiao. All rights reserved.
//

import UIKit

class LotteryOrderViewController: LotteryBaseViewController, UITableViewDelegate, UITableViewDataSource, ServiceDelegate {
    var isFirstAppear = true;
    var gameEn = "";
    var gameId: Int!;
    var gameName = "";
    var periodId: String!;
    var topButtonsView: OrderTopButtonsView!;
    var tableHorizontalLine: UIView!;
    var tableView: UITableView!;
    var headerView: OrderItemTableHeaderView!;
    var footerView: OrderItemTableFooterView!;
    var bottomInfoBarView: OrderBottomInfoBarView!;
    var bottomMultipleBarView: OrderBottomMultipleBarView!;
    var maskButton: UIButton!;
    var ballStringArray = Array<String>();
    var totalOrderNumber = 0;
    var editedRow: Int = 0;
    var navController: LotteryMainBaseViewController!;
    
    var isTermStop = false;
    var isAddNumber = false;
    
    var betService: BetService!;
    var prepayService: PrepayService!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.title = self.gameName;
        
        //NavigationBar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelAction));
        
        //上部按钮
        self.topButtonsView = OrderTopButtonsView(frame: CGRect(x: 0, y: 64+10, width: self.view.frame.width, height: 30));
        self.view.addSubview(self.topButtonsView);
        self.topButtonsView.selfSelectionButton.addTarget(self, action: #selector(selfSelectionAction), for: .touchUpInside);
        self.topButtonsView.machineSelectionButton.addTarget(self, action: #selector(machineSelectionAction), for: .touchUpInside);
        self.topButtonsView.clearListButton.addTarget(self, action: #selector(clearListAction), for: .touchUpInside);
        
        //TableView
        self.tableHorizontalLine = UIView(frame: CGRect(x: 10, y: self.topButtonsView.frame.maxY+10, width: self.view.frame.width-10*2, height: 5));
        self.tableHorizontalLine.backgroundColor = COLOR_BORDER;
        self.tableHorizontalLine.layer.cornerRadius = tableHorizontalLine.frame.height/2;
        self.view.addSubview(self.tableHorizontalLine);
        
        self.tableView = UITableView(frame: CGRect(x: self.tableHorizontalLine.frame.minX+5, y: self.tableHorizontalLine.frame.minY+self.tableHorizontalLine.frame.height/2, width: self.tableHorizontalLine.frame.width-5*2, height: self.view.frame.height-64-30*4));
        self.view.addSubview(self.tableView);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.register(OrderItemTableViewCell.classForCoder(), forCellReuseIdentifier: "cell");
        self.headerView = OrderItemTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 10));
        self.tableView.tableHeaderView = self.headerView;
        self.footerView = OrderItemTableFooterView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 100));
        self.tableView.tableFooterView = self.footerView;
        
        //maskButton
        self.maskButton = UIButton(frame: UIScreen.main.bounds);
        self.maskButton.backgroundColor = COLOR_MASK;
        self.view.addSubview(self.maskButton);
        self.maskButton.addTarget(self, action: #selector(dismissMaskAction), for: .touchUpInside);
        self.maskButton.isHidden = true;
        
        //bottomInfoBar
        self.bottomInfoBarView = OrderBottomInfoBarView(frame: CGRect(x: 0, y: self.view.frame.height-45, width: self.view.frame.width, height: 45));
        self.view.addSubview(self.bottomInfoBarView);
        self.bottomInfoBarView.payButton.addTarget(self, action: #selector(payAction), for: .touchUpInside);
        
        //键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandle(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandle(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandle(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        //Service
        self.betService = BetService(delegate: self);
        self.prepayService = PrepayService(delegate: self);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        let dict = LotteryUtil.selectionList(gameEn: self.gameEn);
        if (self.isFirstAppear == true && dict != nil) {
            if (dict!["list"] != nil) {
                self.ballStringArray = dict!["list"] as! Array<String>;
            }
            
            if (dict!["term"] != nil) {
               self.bottomMultipleBarView.mainView.termTextField.text = String(describing: dict!["term"]!);
                if (dict!["term"] as! Int > 1) {
                    self.bottomMultipleBarView.termStopView.isHidden = false;
                }
            }
            
            if (dict!["isTermStop"] as? Bool == true) {
                self.bottomMultipleBarView.termStopView.stopButton.checkAction();
            }
            
            if (dict!["multiple"] != nil) {
                self.bottomMultipleBarView.mainView.multipleTextField.text = String(describing: dict!["multiple"]!);
            }
            
            if (dict!["isAddNumber"] as? Bool == true) {
                self.bottomMultipleBarView.mainView.addNumberButton.checkAction();
            }
            
            self.tableView.reloadData();
            ViewUtil.showToast(text: "这是您上次保存的号码");
            self.isFirstAppear = false;
            
            LotteryUtil.removeSelectionList(gameEn: self.gameEn);
        }
        self.updateAmountInfo();
        
        self.getPeriodInfo();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getPeriodInfo() {
        self.betService.getPeriods(gameEn: self.gameEn);
    }

    
    func onCompleteSuccess(service: BaseService) {
        ViewUtil.dismissToast();
        if (service == self.betService) {
            let currentSubPeriod = self.betService.currentSubPeriod;
            if (self.periodId != nil && currentSubPeriod != nil && self.periodId != self.betService.currentPeriod.periodId) {
                ViewUtil.showToast(text: "期次已切换，当前是第\(currentSubPeriod!)期");
            }
            self.gameId = self.betService.currentPeriod.gameId;
            self.periodId = self.betService.currentPeriod.periodId;
            if (self.betService.currentPeriod.gameName != nil) {
                self.gameName = self.betService.currentPeriod.gameName!;
                self.title = self.gameName;
            }
        } else if (service == self.prepayService) {
            var wholeLotteryNumber = "";
            for ballString in self.ballStringArray.enumerated() {
                if (ballString.offset == 0) {
                    wholeLotteryNumber = wholeLotteryNumber + ballString.element;
                } else {
                    wholeLotteryNumber = wholeLotteryNumber + "," + ballString.element;
                }
                
            }
            
            var parameters = Dictionary<String, Any>();
            parameters["gameId"] = self.gameId;
            parameters["gameEn"] = self.gameEn;
            parameters["gameName"] = self.gameName;
            parameters["totalPeriod"] = Int(self.bottomMultipleBarView.mainView.termTextField.text!);
            parameters["followMode"] = self.bottomMultipleBarView.termStopView.stopButton.isSelected.hashValue;
            parameters["betTimes"] = Int(self.bottomMultipleBarView.mainView.multipleTextField.text!);
            parameters["periodId"] = self.periodId;
            parameters["lotteryNumber"] = wholeLotteryNumber;
            parameters["orderAmount"] = self.bottomInfoBarView.amount;
            parameters["balanceAmount"]  = self.prepayService.accountBalance;
            parameters["redPacketList"] = self.prepayService.redPacketList;
            parameters["payMethodList"] = self.prepayService.payMethodList;
            if (self.isAddNumber == true) {
               parameters["gameExtra"] = "ZHUIJIA";
            }
            LotteryRoutes.routeURLString(HostRouter.JUMP_HOST + HostRouter.PAY, withParameters: parameters);
        }
        
    }
    
    func keyboardHandle(_ notification: Notification){
        //获取userInfo
        let kbInfo = notification.userInfo
        //获取键盘的size
        let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //键盘的y偏移量
        let changeY = kbRect.origin.y - SCREEN_HEIGHT;
        //键盘弹出的时间
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        //界面偏移动画
        UIView.animate(withDuration: duration) {
            if (notification.name == NSNotification.Name.UIKeyboardWillShow) {
                self.bottomMultipleBarView.transform = CGAffineTransform(translationX: 0, y: changeY + 5);
                self.maskButton.isHidden = false;
                
            } else if (notification.name == NSNotification.Name.UIKeyboardWillHide) {
                self.bottomMultipleBarView.transform = CGAffineTransform(translationX: 0, y: -changeY + self.bottomMultipleBarView.termStopView.frame.minY-self.bottomMultipleBarView.mainView.frame.minY);
                self.maskButton.isHidden = true
            }
        }
        
        if (notification.name == NSNotification.Name.UIKeyboardWillShow || notification.name == NSNotification.Name.UIKeyboardWillHide) {
           self.bottomMultipleBarView.termView.isHidden = !self.bottomMultipleBarView.mainView.termTextField.isFirstResponder;
        }

        self.bottomMultipleBarView.termTextFieldDidChange();
        self.bottomMultipleBarView.multipleTextFieldDidChange();
                
        self.updateAmountInfo();
        
    }
    
    func dismissMaskAction() {
        for view in self.bottomMultipleBarView.mainView.subviews {
            if (view.isKind(of: UITextField.classForCoder())) {
                view.resignFirstResponder();
            }
        }
        self.maskButton.isHidden = true;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.ballStringArray.count != 0) {
            return self.ballStringArray.count;
        }
        return 0;
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let content = self.ballStringArray[indexPath.row];
        var ballContent = content;
        if (content.contains("[")) {
            ballContent = CommonUtil.subStringFromChar(string: content, character: "[");
        }
        let height = CommonUtil.getLabelHeight(text: ballContent, width: SCREEN_WIDTH-120, font: UIFont.boldSystemFont(ofSize: 18)) + 50;
        return height;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderItemTableViewCell;
        cell.separatorInset = UIEdgeInsets.zero;
        let ballNumberString = self.ballStringArray[indexPath.row];
        let ballContent = CommonUtil.subStringFromChar(string: ballNumberString, character: "[");
        
        cell.setData(ballNumberString: ballContent, detailString: self.toCellDetailString(ballString: ballNumberString));
        cell.deleteButton.tag = indexPath.row;
        cell.deleteButton.addTarget(self, action: #selector(deleteItemAction(_:)), for: .touchUpInside);
        return cell;
    }
    
    func toCellDetailString(ballString: String) -> String {
        return "";
    }
    
    func toOrderNumber(ballString: String) -> Int {
        return 0;
    }
    
    func updateTableView() {
        //UpdateDeleteButtonTag
        for i in 0..<self.ballStringArray.count {
            let cell = self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? OrderItemTableViewCell;
            cell?.deleteButton.tag = i;
        }
        
        //RuleLabelIsHidden
        if (self.ballStringArray.count > 0) {
            self.footerView.checkBoxImageView.isHidden = false;
            self.footerView.ruleLabel.isHidden = false;
        } else {
            self.footerView.checkBoxImageView.isHidden = true;
            self.footerView.ruleLabel.isHidden = true;
        }
        
        self.updateAmountInfo();
    }
    
    func insertRows(newArray: Array<String>) {
        self.ballStringArray = newArray + self.ballStringArray;
        
        if (self.tableView != nil) {
            var indexPaths = Array<IndexPath>();
            for i in 0..<newArray.count {
                let indexPath = IndexPath(row: i, section: 0);
                indexPaths.append(indexPath);
            }
            self.tableView.beginUpdates();
            self.tableView.insertRows(at: indexPaths, with: .top);
            self.tableView.endUpdates();
            self.updateTableView();
        }
    }
    
    func deleteItemAction(_ button: UIButton) {
        self.ballStringArray.remove(at: button.tag);
        var indexPaths = Array<IndexPath>();
        let indexPath = NSIndexPath(row: button.tag, section: 0);
        indexPaths.append(indexPath as IndexPath);
        self.tableView.beginUpdates();
        self.tableView.deleteRows(at: indexPaths, with: .bottom)
        self.tableView.endUpdates();
        self.updateTableView();
    }
    
    func selfSelectionAction() {
        self.editedRow = 0;
        self.navController.gameEn = self.gameEn;
        self.navController.gameName = self.gameName;
        self.navController.gameId = self.gameId;
        self.pushViewController(viewController: self.navController);
    }
    
    func machineSelectionAction() {
        self.editedRow = 0;
    }
    
    func clearListAction() {
        if (self.ballStringArray.count == 0) {
            return;
        }
        
        let alertController = UIAlertController(title: nil, message: "确定清空当前投注列表？", preferredStyle: .alert);
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil);
        let confirmAction = UIAlertAction(title: "确定", style: .default) { (action) in
            self.ballStringArray.removeAll();
            for view in self.bottomMultipleBarView.mainView.subviews {
                if (view.isKind(of: UITextField.classForCoder())) {
                    (view as! UITextField).text = "1";
                }
            }
            self.tableView.reloadData();
            self.updateTableView();
            
            LotteryUtil.removeSelectionList(gameEn: self.gameEn);
        }
        alertController.addAction(cancelAction);
        alertController.addAction(confirmAction);
        alertController.show();
    }
    
    func updateAmountInfo() {
        
    }
    
    func cancelAction() {
        if (self.ballStringArray.count == 0) {
            _ = self.navigationController?.popToRootViewController(animated: true);
            return;
        }
        
        self.bottomMultipleBarView.mainView.termTextField.textFieldDidEndEditing(self.bottomMultipleBarView.mainView.termTextField);
        self.bottomMultipleBarView.mainView.multipleTextField.textFieldDidEndEditing(self.bottomMultipleBarView.mainView.multipleTextField);
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet);
        let removeAction = UIAlertAction(title: "清除", style: .destructive) { (action) in
            LotteryUtil.removeSelectionList(gameEn: self.gameEn);
            _ = self.navigationController?.popToRootViewController(animated: true);
        }
        let saveAction = UIAlertAction(title: "保存", style: .default) { (action) in
            LotteryUtil.saveSelectionList(list: self.ballStringArray, term: Int(self.bottomMultipleBarView.mainView.termTextField.text!)!, isTermStop: self.bottomMultipleBarView.termStopView.stopButton.isSelected,multiple: Int(self.bottomMultipleBarView.mainView.multipleTextField.text!)!, isAddNumber: self.isAddNumber, gameEn: self.gameEn);
            
            ViewUtil.showToast(text: "已保存，下次进入将自动调出");
            _ = self.navigationController?.popToRootViewController(animated: true);
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil);
        alertController.addAction(removeAction);
        alertController.addAction(saveAction);
        alertController.addAction(cancelAction);
        alertController.show();
    }
    
    func payAction() {
        if (self.gameId == nil || self.periodId == nil) {
            ViewUtil.showProgressToast(text: "正在获取当前期次");
            self.betService.getPeriods(gameEn: self.gameEn);
            return;
        }
        
        if (LotteryUtil.isLogin() != true) {
            LotteryUtil.shouldLogin();
            return;
        }
        var isFollow = false;
        let totalPeriod = Int(self.bottomMultipleBarView.mainView.termTextField.text!);
        if (totalPeriod != nil && totalPeriod != 1) {
            isFollow = true;
        }
        self.prepayService.getPrepayInfo(gameId: self.gameId, orderAmount:self.bottomInfoBarView.amount, isFollow: isFollow);
    }
    
}
